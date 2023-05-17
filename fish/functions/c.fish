function c
    if count $argv >0
        set target_dir $argv[1]
        if string match "^~" $target_dir
            set target_dir (string replace $target_dir "~" $home)
        end
    else
        set target_dir $HOME
    end

    if test -d "$target_dir"; or test $target_dir = -
        cd "$target_dir"
        set dir (pwd)
        while test "$dir" != /
            if test -d "$dir/.venv"; and test -f "$dir/.venv/bin/activate.fish"
                source "$dir/.venv/bin/activate.fish"
                if test -e 0
                    if test -e 0 -a (stat -c '%Y' 0) -gt (date +%s -d 'now - 1 minute')
                        rm 0
                    end
                end

                ls

                return 0
            end
            set dir (dirname "$dir")
        end

        # No venv found  
        if test -e "$virtual_env"
            deactivate
        end
        return 0

    else
        echo "the directory $target_dir does not exist."
        return 1
    end
end
