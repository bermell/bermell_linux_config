#!/bin/zsh
# Alacritty runs this as its "shell" instead of zellij directly.
#
# Three jobs:
#
# 1. Short IPC socket dir. macOS caps AF_UNIX paths at 103 bytes. The default
#    $TMPDIR here is 79 bytes of prefix, leaving only 24 for a session name —
#    so e.g. "1_platform_episodic_memory" (26) died with
#    "the IPC socket path is too long". /tmp/zellij-<uid> leaves 68.
#
# 2. Keep the window open when zellij exits non-zero, or when a new macOS crash
#    report appeared while it ran — otherwise Alacritty closes and the error is
#    never seen. Every exit is also appended to $EXITLOG for later correlation.
#
# 3. Refuse to quietly attach to a server left over from a previous zellij
#    version. A server keeps running its own exec image, so `brew upgrade`
#    while sessions are alive leaves old servers behind. Handing one a new
#    client is not a clean version error: on 2026-08-26 a 0.45.0 client hit
#    two 0.44.3 servers (platform_one, platform_two) and both died with heap
#    corruption in their `screen` thread — invalid free, no Rust panic. The
#    socket dir stayed contract_version_1 across that upgrade, so zellij's
#    own compatibility gate never fired. Set ZJ_SKIP_STALE_GUARD=1 to bypass.
#
#    NOTE: version skew is not the whole story. On 2026-09-02 a server that was
#    started *after* the current 0.45.0 binary was linked (so the guard was
#    right not to fire) died the same way after ~47h of uptime: SIGSEGV,
#    KERN_INVALID_ADDRESS at 0x0, in _platform_memmove on its `screen` thread.
#    Same thread, same shape, no version mismatch — so the underlying fault is
#    an upstream 0.45.0 bug, and the guard only removes one trigger for it.
#    The Homebrew binary is fully stripped, so frames past memmove cannot be
#    symbolicated locally; keep the .ips files for an upstream report.

ZELLIJ=/opt/homebrew/bin/zellij
REPORTS=$HOME/Library/Logs/DiagnosticReports
EXITLOG=$HOME/.local/state/zellij-launch-exits.log

# --- short socket dir -------------------------------------------------------
# /tmp is world-writable, so refuse to use a path we don't own.
SOCKDIR=/tmp/zellij-$(id -u)
if [[ -L $SOCKDIR ]] || { [[ -e $SOCKDIR ]] && [[ ! -O $SOCKDIR || ! -d $SOCKDIR ]]; }; then
    print -u2 -- "zellij-launch: $SOCKDIR is not a directory we own; using default socket dir."
else
    mkdir -p -m 700 $SOCKDIR 2>/dev/null && chmod 700 $SOCKDIR 2>/dev/null
    export ZELLIJ_SOCKET_DIR=$SOCKDIR
fi

ZJ_LOG=${TMPDIR:-/tmp/}zellij-$(id -u)/zellij-log/zellij.log

# --- stale-server guard -----------------------------------------------------
# Servers are daemonized (ppid 1) and carry their session name as the last path
# component of `--server <socket>`. Anything started before the current binary
# was linked into place is running a different image than the client we are
# about to spawn.
zj_stale_servers() {
    local installed t real pid ppid w mo dy tm yr cmd start

    real=${ZELLIJ:A}
    installed=$(stat -f %c "$ZELLIJ" 2>/dev/null) || return 0
    t=$(stat -f %c "$real" 2>/dev/null)
    [[ -n $t ]] && (( t > installed )) && installed=$t
    [[ -n $installed ]] || return 0

    ps -eo pid=,ppid=,lstart=,command= | while read -r pid ppid w mo dy tm yr cmd; do
        [[ $ppid == 1 ]] || continue
        [[ $cmd == *"/zellij --server "* ]] || continue
        start=$(date -j -f "%a %b %d %T %Y" "$w $mo $dy $tm $yr" +%s 2>/dev/null) || continue
        (( start < installed )) || continue
        print -r -- "$pid ${cmd##*/} (started $mo $dy $tm)"
    done
}

if [[ -z $ZJ_SKIP_STALE_GUARD ]]; then
    stale=$(zj_stale_servers)
    if [[ -n $stale ]]; then
        print -r -- ""
        print -r -- "──────────────────────────────────────────────────────────────"
        print -r -- " STALE ZELLIJ SERVERS — older than the installed binary"
        print -r -- " ($ZELLIJ linked $(stat -f %Sc -t '%F %T' $ZELLIJ 2>/dev/null), $($ZELLIJ --version 2>/dev/null))"
        print -r -- ""
        print -r -- "$stale" | sed 's/^/   /'
        print -r -- ""
        print -r -- " Attaching to one of these can kill it with heap corruption."
        stale_pids=(${${(f)stale}%% *})
        print -r -- " Restart them first:  kill $stale_pids"
        print -r -- "──────────────────────────────────────────────────────────────"
        print -rn -- " Press Enter to continue anyway (Ctrl-C to abort). "
        read -r _
    fi
fi

# Crash-report snapshot. The (N) qualifier matters: with zsh's default nomatch,
# an empty DiagnosticReports dir makes the glob an *error*, the count comes out
# empty, and the comparison below silently never fires. That is what happened on
# 2026-09-02 — "no matches found" twice, new_crash_reports=0, and a real
# zellij-2026-09-02-084026.ips sitting on disk unmentioned.
zj_reports() { print -r -- $REPORTS/zellij-*.ips(N) }

before=(${(f)"$(zj_reports)"})
before=(${before:#})

"$ZELLIJ" "$@"
rc=$?

# ReportCrash writes the .ips a moment after the process dies, so a single
# check right here races it. Poll briefly, but only when zellij failed.
after=($before)
if [[ $rc -ne 0 ]]; then
    for _ in {1..10}; do
        after=(${(f)"$(zj_reports)"}); after=(${after:#})
        (( $#after > $#before )) && break
        sleep 0.5
    done
fi

mkdir -p ${EXITLOG:h} 2>/dev/null
print -r -- "$(date '+%F %T')  status=$rc  new_crash_reports=$(( $#after - $#before ))  sockdir=${ZELLIJ_SOCKET_DIR:-default}" >> $EXITLOG 2>/dev/null

if [[ $rc -ne 0 || $#after -gt $#before ]]; then
    newest_all=($REPORTS/zellij-*.ips(Nom))   # Nom: no-match-ok, newest first
    newest=$newest_all[1]
    print -r -- ""
    print -r -- "──────────────────────────────────────────────────────────────"
    print -r -- " zellij exited: status $rc   ($(date '+%F %T'))"
    if [[ $#after -gt $#before ]]; then
        print -r -- " A NEW CRASH REPORT WAS WRITTEN — the server crashed."
        print -r -- "   $newest"
        # Fingerprint it inline — signal plus faulting-thread name is what
        # distinguishes one recurrence from another when reporting upstream.
        python3 -c '
import json,sys
raw=open(sys.argv[1]).read().split("\n",1)
b=json.loads(raw[1])
e=b.get("exception",{}) or {}
th=b.get("threads",[])
i=b.get("faultingThread")
name=(th[i].get("name") or th[i].get("queue") or "?") if isinstance(i,int) and i<len(th) else "?"
top="?"
if isinstance(i,int) and i<len(th) and th[i].get("frames"):
    f=th[i]["frames"][0]
    top=f.get("symbol") or hex(f.get("imageOffset",0))
print("   %s (%s) in %s on thread %r  [pid %s, up %s]" % (
    e.get("signal","?"), e.get("subtype") or e.get("type",""), top, name,
    b.get("pid","?"), b.get("procLaunch","?")))
' "$newest" 2>/dev/null
    fi
    print -r -- " Server log: $ZJ_LOG"
    print -r -- " Exit log:   $EXITLOG"
    print -r -- " Sessions:   zellij list-sessions   (resurrect with: zellij attach)"
    print -r -- "──────────────────────────────────────────────────────────────"
    print -rn -- " Press Enter to close this window. "
    read -r _
fi

exit $rc
