#!/bin/zsh
# Alacritty runs this as its "shell" instead of zellij directly.
#
# Two jobs:
#
# 1. Short IPC socket dir. macOS caps AF_UNIX paths at 103 bytes. The default
#    $TMPDIR here is 79 bytes of prefix, leaving only 24 for a session name —
#    so e.g. "1_platform_episodic_memory" (26) died with
#    "the IPC socket path is too long". /tmp/zellij-<uid> leaves 68.
#
# 2. Keep the window open when zellij exits non-zero, or when a new macOS crash
#    report appeared while it ran — otherwise Alacritty closes and the error is
#    never seen. Every exit is also appended to $EXITLOG for later correlation.

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

before=$(ls -1 $REPORTS/zellij-*.ips 2>/dev/null | wc -l | tr -d ' ')

"$ZELLIJ" "$@"
rc=$?

after=$(ls -1 $REPORTS/zellij-*.ips 2>/dev/null | wc -l | tr -d ' ')

mkdir -p ${EXITLOG:h} 2>/dev/null
print -r -- "$(date '+%F %T')  status=$rc  new_crash_reports=$((after - before))  sockdir=${ZELLIJ_SOCKET_DIR:-default}" >> $EXITLOG 2>/dev/null

if [[ $rc -ne 0 || $after -gt $before ]]; then
    newest=$(ls -1t $REPORTS/zellij-*.ips 2>/dev/null | head -1)
    print -r -- ""
    print -r -- "──────────────────────────────────────────────────────────────"
    print -r -- " zellij exited: status $rc   ($(date '+%F %T'))"
    if [[ $after -gt $before ]]; then
        print -r -- " A NEW CRASH REPORT WAS WRITTEN — the server crashed."
        print -r -- "   $newest"
    fi
    print -r -- " Server log: $ZJ_LOG"
    print -r -- " Exit log:   $EXITLOG"
    print -r -- " Sessions:   zellij list-sessions   (resurrect with: zellij attach)"
    print -r -- "──────────────────────────────────────────────────────────────"
    print -rn -- " Press Enter to close this window. "
    read -r _
fi

exit $rc
