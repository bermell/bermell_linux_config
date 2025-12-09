function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l python_color (set_color bryellow)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    # set -q fish_prompt_pwd_dir_length
    # or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end
    # set -l prompt (echo -s -n $python_color '(' (get_pyenv_virtual) ') ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_status ' ' )
    set -l prompt (echo -s -n $python_color '(-not-set-) ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal $prompt_status ' ' )
    set -l final_prompt (echo -s -n $status_color $suffix ' ' $normal)

    echo -e -n $prompt

    set -l cwd (pwd)
    set -l cwd_last (basename $cwd)

    # zellij action rename-tab $cwd_last

    # test if the length of prompt is longer than the terminal width
    # set -l prompt_length (string length $prompt)
    # set -l terminal_width (command tput cols)
    # if test $prompt_length -gt (math $terminal_width - 40)
    echo -e -n "\n"
    # end

    echo -e -n $final_prompt
end
