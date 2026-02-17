# Lazy-load VirtualFish: only load when vf is first used (saves ~100-200ms per shell)
function vf --description "VirtualFish: fish plugin to manage virtualenvs (lazy-loaded)"
    set -l vf_loader $HOME/.pyenv/versions/3.8.16/lib/python3.8/site-packages/virtualfish/virtual.fish
    if test -f $vf_loader
        set -g VIRTUALFISH_VERSION 2.5.5
        set -g VIRTUALFISH_PYTHON_EXEC $HOME/.pyenv/versions/3.8.16/bin/python
        source $vf_loader
        emit virtualfish_did_setup_plugins
        vf $argv
    else
        echo "VirtualFish not found at $vf_loader"
        return 1
    end
end
