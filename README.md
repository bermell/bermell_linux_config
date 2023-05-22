# Simple installs
Install some reasonable tools and all dependencies for the more advanced package installers 

First, use snap (ubuntu software) to install gnome-tweaks, open and bind caoslock to be ctrl 

```shell 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb 
sudo apt install nodejs tmux htop vim curl git gh make fuse build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```
Use snap to install slack vscode discord

Installing fuse does something with the kernel so best to restart here

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
Then you need to do restart computer, then run `vf install` 

## Neovim 
`pip install jupyter-client Pillow cairosvg pnglatex plotly kaleido`

```shell
mkdir ~/.fonts && cd ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Hack.zip 
unzip Hack.zip 
rm Hack.zip 
fc-cache -fv 
```

```shell
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
mv nvim.appimage ~/.config/nvim/nvim.appimage
chmod +x ~/.config/nvim/nvim.appimage
```

## Rust 
```shell 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path ~/.cargo/bin/
```

## Config files to link 
```shell
ln -s $HOME/.config/gitconfig $HOME/.gitconfig
ln -s $HOME/.config/tmux.conf $HOME/.tmux.conf
```

## tmux yank goes to clipboard too 
Something with xclip 

 |

# Install proper keybindings
  - paragraph -> Alt Gr

## Vim bindings for navigation in non-terminal programs
Want to bind:
 - <modifier>h -> left  
 - <modifier>j -> down
 - <modifier>k -> up
 - <modifier>l -> right
 - <modifier>b -> ctrl+left
 - <modifier>e -> ctrl+right

