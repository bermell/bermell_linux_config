if status is-interactive
    # Commands to run in interactive sessions can go here
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    # set environment variables for jenkins validation
    set -x JENKINS_USER_ID Mattias
    set -x JENKINS_PASSWORD lessfuckedchar
    set -x JENKINS_URL https://butler.modl.ai
    set -x JENKINS_INSECURE true

end

# Static Homebrew path (avoids ~200ms brew shellenv subprocess; use brew shellenv if paths change)
if test -d /opt/homebrew
    fish_add_path --global --path /opt/homebrew/bin /opt/homebrew/sbin
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
end

# Cached pyenv init for faster shell startup. Auto-regenerates when the pyenv
# binary is newer than the cache (e.g. after `brew upgrade pyenv`).
set -q PYENV_ROOT; or set -gx PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
    set -l pyenv_fish_init $PYENV_ROOT/fish_init.fish
    set -l pyenv_bin (command -v pyenv)
    if not test -f $pyenv_fish_init; or test -n "$pyenv_bin" -a $pyenv_fish_init -ot $pyenv_bin
        set -gx PATH $PYENV_ROOT/bin $PATH
        # pyenv hardcodes a versioned Cellar path for its completions, which
        # breaks on upgrade; rewrite it to the stable brew opt symlink.
        pyenv init - --no-rehash fish \
            | string replace -r "/Cellar/pyenv/[^/']+/" '/opt/pyenv/' >$pyenv_fish_init
    end
    source $pyenv_fish_init
end

# macOS caps AF_UNIX socket paths at 103 bytes. The default $TMPDIR here eats 79
# of them, leaving only 24 for a zellij session name — longer names fail with
# "the IPC socket path is too long". Keep this in sync with the value in
# alacritty/zellij-launch.sh, or the two disagree about which sessions exist.
if test -d /tmp
    set -l zj_sock /tmp/zellij-(id -u)
    if not test -L $zj_sock; and begin; not test -e $zj_sock; or test -d $zj_sock -a -O $zj_sock; end
        mkdir -m 700 -p $zj_sock 2>/dev/null
        set -gx ZELLIJ_SOCKET_DIR $zj_sock
    end
end

fish_user_key_bindings

set -x JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
set -x PATH $JAVA_HOME/bin $PATH
