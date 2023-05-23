function get_pyenv_virtual --description 'print information about currently active virtual environment'
    set -l vari (pyenv which python)
    set -l parts (string split "/" $vari)
    set -l length (count $parts)

    if test $length -ge 3
        set -l index (math $length - 2)
        echo $parts[$index]
    else
        echo ""
    end
end
