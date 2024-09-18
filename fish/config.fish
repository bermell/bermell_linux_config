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
end

pyenv init - | source

fish_user_key_bindings

set -x JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
set -x PATH $JAVA_HOME/bin $PATH
