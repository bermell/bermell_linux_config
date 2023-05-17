# Simple installs
Install some reasonable tools and all dependencies for the more advanced package installers 

`sudo apt install nodejs tmux vim curl git gh make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev`

# Custom installs (in order) 
## pyenv and python 
```shell 
curl https://pyenv.run | bash
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
```
Then you want to restart/reload the shell.  

```shell
pyenv install 3.8 
pyenv install 3.9 
pyenv global 3.9 
```

## lazygit 
https://github.com/jesseduffield/lazygit#ubuntu 

## fish 
```shell 
sudo apt-add-repository ppa:fish-shell/release-3 && sudo apt update && sudo apt install fish
python -m pip install virtualfish
```
Then you need to do <something clever> to updates paths or something. Then run `vf install` 

## Neovim 
`pip install jupyter-client  Pillow cairosvg pnglatex plotly kaleido`

```shell
mkdir ~/.fonts && cd ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Hack.zip 
unzip Hack.zip 
rm Hack.zip 
fc-cache -fv 
```
Pick a [Neovim release, use the .tar.gz](https://github.com/neovim/neovim/releases) 

```shell
wget https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz 
rm nvim-linux64.tar.gz 
mv nvim-linux64/bin/nvim ~/.config/nvim/nvim.appimage
```


# Packages to install 
| Program | comment | dependencies  
| [rustup]() | |
| [nvim]() | | `sudo apt install fuse` `pip install jupyter-client  Pillow cairosvg pnglatex plotly kaleido` https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0 to install nerdfonts 
| [tmux]() | sudo apt install xclip 
 |

# Install proper keybindings
  - caps lock -> ctrl 
  - paragraph -> Alt Gr

## Vim bindings for navigation in non-terminal programs
Want to bind:
 - <modifier>h -> left  
 - <modifier>j -> down
 - <modifier>k -> up
 - <modifier>l -> right
 - <modifier>b -> ctrl+left
 - <modifier>e -> ctrl+right

