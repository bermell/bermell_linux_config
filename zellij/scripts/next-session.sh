#!/bin/sh
# Switch to the next (or previous, with `prev`) zellij session, cyclically.
#
# Order is whatever `zellij list-sessions` reports, i.e. ascending by session
# creation time -- the same order the session-manager shows, not alphabetical.
#
# Run from a keybind as a floating pane; see zellij/config.kdl. On success the
# pane exits immediately and `close_on_exit true` disposes of it. On failure it
# blocks on `read` so the error stays on screen instead of flashing past.

die() {
	printf 'next-session: %s\n\nPress Enter to dismiss.\n' "$1" >&2
	# shellcheck disable=SC2034
	read -r _dismiss
	exit 1
}

# A `Run` pane inherits the zellij *server's* environment, not an interactive
# shell's, so Homebrew is not necessarily on PATH here.
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
zj=$(command -v zellij) || die "cannot find the \`zellij\` binary (PATH=$PATH)"

current="$ZELLIJ_SESSION_NAME"
[ -n "$current" ] || die "ZELLIJ_SESSION_NAME is not set -- not running inside a zellij pane?"

sessions=$("$zj" list-sessions --short) || die "\`zellij list-sessions\` failed"
[ -n "$sessions" ] || die "no sessions reported"

case "$1" in
prev | previous) step=-1 ;;
*) step=1 ;;
esac

# Fail loudly rather than silently defaulting to the first session, which is
# what an unset index in the modulo below would otherwise do.
next=$(
	printf '%s\n' "$sessions" | awk -v cur="$current" -v step="$step" '
		{ name[NR] = $0 }
		$0 == cur { i = NR }
		END {
			if (!i) { exit 3 }
			if (NR == 1) { exit 4 }
			print name[(i - 1 + step + NR) % NR + 1]
		}'
)
case $? in
3) die "current session \"$current\" is not in the session list" ;;
4) die "\"$current\" is the only session" ;;
esac

"$zj" action switch-session "$next" || die "failed to switch to \"$next\""
