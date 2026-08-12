#!/bin/zsh
# Alacritty runs this as its "shell" instead of zellij directly.
#
# Why: when the zellij *server* crashes, the client exits and Alacritty closes
# the window with it — so the crash is never visible. This holds the window open
# whenever zellij exits non-zero, or whenever a new macOS crash report for
# zellij appeared while it was running, and points at the evidence.

ZELLIJ=/opt/homebrew/bin/zellij
REPORTS=$HOME/Library/Logs/DiagnosticReports
ZJ_LOG=${TMPDIR:-/tmp/}zellij-$(id -u)/zellij-log/zellij.log

before=$(ls -1 $REPORTS/zellij-*.ips 2>/dev/null | wc -l | tr -d ' ')

"$ZELLIJ" "$@"
status=$?

after=$(ls -1 $REPORTS/zellij-*.ips 2>/dev/null | wc -l | tr -d ' ')

if [[ $status -ne 0 || $after -gt $before ]]; then
    newest=$(ls -1t $REPORTS/zellij-*.ips 2>/dev/null | head -1)
    print -r -- ""
    print -r -- "──────────────────────────────────────────────────────────────"
    print -r -- " zellij exited: status $status   ($(date '+%F %T'))"
    if [[ $after -gt $before ]]; then
        print -r -- " A NEW CRASH REPORT WAS WRITTEN — the server crashed."
        print -r -- "   $newest"
    fi
    print -r -- " Server log: $ZJ_LOG"
    print -r -- " Sessions:   zellij list-sessions   (resurrect with: zellij attach)"
    print -r -- "──────────────────────────────────────────────────────────────"
    print -rn -- " Press Enter to close this window. "
    read -r _
fi

exit $status
