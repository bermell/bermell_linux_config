function fresh_venv --description 'Create a new python virtual environment with pyenv and activate it'
    argparse --name=fresh_venv f/force -- $argv

    if test (count $argv) -eq 0
        set -f _py_version ""
    else if test (count $argv) -eq 1
        set -f _py_version $argv[1]
    else
        echo "Usage: fresh_venv [-f|--force] [pyversion]"
        return 1
    end

    set -l local_dir (basename (pwd))
    if pyenv versions | grep -q $local_dir
        if set -q _flag_force
            echo "virtual env $local_dir already exists, but will be recreated"
            pyenv deactivate
            pyenv virtualenv-delete -f $local_dir
        else
            echo "Virtual environment $local_dir already exists, exiting!"
            return 1
        end
    end
    echo "Creating virtual environment $local_dir"
    pyenv virtualenv $_py_version $local_dir
    pyenv activate $local_dir

end
