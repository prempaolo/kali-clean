#!/bin/bash

DIR="$HOME/.local/share/apps"

sudo apt update
sudo apt install libx11-dev libxinerama-dev libxft-dev libx11-xcb-dev libxcb-res0-dev libharfbuzz-dev suckless-tools fzf xwallpaper golang sxiv rofi neovim

mkdir -p $DIR

# Check if dwm is already present and otherwise install it
if [[ ! -e "$DIR/dwm" ]]; then
	git clone https://github.com/prempaolo/dwm.git "$DIR/dwm"
else
	cd "$DIR/dwm"
	git pull
fi
cd "$DIR/dwm"
make && sudo make install

# Check if st is already present and otherwise install it
if [[ ! -e "$DIR/st" ]]; then
	git clone https://github.com/prempaolo/st.git "$DIR/st"
else
	cd "$DIR/st"
	git pull
fi
cd "$DIR/st"
make && sudo make install

# Check if dwmblocks is already present and otherwise install it
if [[ ! -e "$DIR/dwmblocks" ]]; then
	git clone https://github.com/prempaolo/dwmblocks.git "$DIR/dwmblocks"
else
	cd "$DIR/dwmblocks"
	git pull
fi
cd "$DIR/dwmblocks"
make && sudo make install

# Check if dotfiles is already present and otherwise install it
if [[ ! -e "$DIR/dotfiles" ]]; then
	git clone https://github.com/prempaolo/dotfiles.git "$DIR/dotfiles"
else
	cd "$DIR/dotfiles"
	git pull
fi
cd "$DIR/dotfiles"
make && sudo make install

# Download and install font 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
unzip Meslo.zip -d meslo
mkdir -p "$HOME/.fonts"
mv meslo/* "$HOME/.fonts/"
rm Meslo.zip
rm -r meslo
wget https://github.com/powerline/fonts/raw/master/UbuntuMono/Ubuntu%20Mono%20derivative%20Powerline.ttf -P "$HOME/.fonts"
fc-cache -fv

# Download and install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh "$HOME/.local/share/oh-my-zsh" >/dev/null 2>&1
mv "$HOME/.zshrc" "$HOME/.zshrc.old"
cp "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"

# Download wallpapers
[ ! -d "$HOME/Pictures" ] && mkdir "$HOME/Pictures"
git clone https://github.com/prempaolo/wallpapers "$HOME/Pictures/wallpapers" >/dev/null 2>&1

# Install lf
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
sudo mv "$HOME/go/bin/lf" /bin/lf

# Configure
# sudo touch "$HOME/.xinitrc"
# echo "exec dwm" | sudo tee "$HOME/.xinitrc"
"$DIR/dotfiles/.local/bin/tools/copy-dotfiles -i $DIR/dotfiles/"

ln -s ~/.xinitrc ~/.xsession
sudo chmod 755 ~/.xinitrc
sudo touch /usr/share/xsessions/custom-dwm.desktop
echo "[Desktop Entry]
Name=Custom-DWM
Exec=/etc/X11/Xsession" | sudo tee /usr/share/xsessions/custom-dwm.desktop