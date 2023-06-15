# Simple installs
Install some reasonable tools and all dependencies for the more advanced package installers 

First, use snap (ubuntu software) to install gnome-tweaks, open and bind caoslock to be ctrl 

```shell 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb 
sudo apt install nodejs tmux htop vim curl git gh make fuse build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```
## Snap installs
```shell
sudo snap install slack vscode discord gathertown
snap connect gathertown:audio-record
snap connect gathertown:camera
```

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
## Docker 
[https://docs.docker.com/desktop/install/ubuntu/](https://docs.docker.com/desktop/install/ubuntu/) 
install the docker desktop first, on linux that is very different from the docker engine that runs on the host natively...

[https://github.com/jesseduffield/lazydocker#binary-release-linuxosxwindows](https://github.com/jesseduffield/lazydocker#binary-release-linuxosxwindow) like lazygit for docker. Awesome!

## Config files to link 
```shell
ln -s $HOME/.config/gitconfig $HOME/.gitconfig
ln -s $HOME/.config/tmux.conf $HOME/.tmux.conf
```

## Install proper keybindings
Open a GUI program called `Startup Applications Prefencenes` and make it run `/usr/bin/xmodmap /home/mattias/.config/Xmodmap` on startup if it's not already there. 
`xcape -e 'ISO_Level3_Shift=Escape`

## TODO bindings 
 - <modifier>b -> ctrl+left
 - <modifier>e -> ctrl+right

