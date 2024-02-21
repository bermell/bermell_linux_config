# My Linux setup

## Simple installs

Install some reasonable tools and all dependencies for the more advanced package
installers

First, use snap (ubuntu software) to install gnome-tweaks, open and bind
capslock to be ctrl

```shell
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
 && sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install nodejs tmux htop vim curl git gh make fuse build-essential \
 libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
 libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
 liblzma-dev fzf btop fd-find kitty exa
```

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

```shell
cargo install sd tldr
```

## Snap installs

```shell
sudo snap install slack vscode discord gathertown diff-so-fancy
snap connect gathertown:audio-record
snap connect gathertown:camera
```

Installing fuse does something with the kernel so best to restart here

## Custom installs (in order)

### fish shell

```shell
sudo apt-add-repository ppa:fish-shell/release-3 && sudo apt update
sudo apt install fish
python -m pip install virtualfish
```

Then you need to do restart computer, then run `vf install`

### pyenv and python

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

### lazygit

[Install instructions](https://github.com/jesseduffield/lazygit#ubuntu)

### Neovim

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

wget https://github.com/neovide/neovide/releases/download/0.12.2/neovide.AppImage
mv neovide.AppImage ~/.config/nvim/neovide.appimage
chmod +x ~/.config/nvim/neovide.appimage
```

### Rust

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path ~/.cargo/bin/
```

### Docker

[https://docs.docker.com/desktop/install/ubuntu/](https://docs.docker.com/desktop/install/ubuntu/)
install the docker desktop first, on Linux that is very different from the
docker engine that runs on the host natively...

[https://github.com/jesseduffield/lazydocker#binary-release-linuxosxwindows](https://github.com/jesseduffield/lazydocker#binary-release-linuxosxwindow)
like `lazygit` for docker. Awesome!

### Config files to link

```shell
ln -s $HOME/.config/gitconfig $HOME/.gitconfig
ln -s $HOME/.config/tmux.conf $HOME/.tmux.conf
```

## Personalization

### Kmonad - keyboard layout

Download the binary from [kmonad github](https://github.com/kmonad/kmonad/releases).
Make it executable and put it in `/home/mattias/.local/bin/kmonad`
We want to run kmonad as a user with the minimal privilages needed [see more](https://dev.to/ram535/kmonad-and-the-power-of-infinite-leader-keys-888).

```shell
sudo usermod -aG input $USER
sudo groupadd uinput
sudo usermod -aG uinput $USER

echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'\
 | sudo tee /etc/udev/rules.d/90-uinput.rules

echo uinput | sudo tee /etc/modules-load.d/uinput.conf
```

Now add it as a service to ubuntu:

```shell
sudo ln -s /home/mattias/.config/kmonad/kmonad.service /etc/systemd/system/kmonad.service
sudo systemctl daemon-reload  # this will register the new service to the deamon
sudo systemctl enable kmonad.service # enable on boot
sudo systemctl start kmonad.service # start now
sudo systemctl status kmonad.service
journalctl -u kmonad.service # to check the logs
```

To restart it after a config update run `sudo systemctl restart kmonad.service`
