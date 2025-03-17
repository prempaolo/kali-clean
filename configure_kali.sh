#!/usr/bin/sh

sudo apt update && sudo apt install i3, i3status, dmenu, fzf, feh, lf

sudo update-alternatives --install /usr/bin/x-session-manager x-session-manager /usr/bin/i3 60

bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
echo "
eval \"\$(navi widget zsh)\"" >> /home/kali/.zshrc

mkdir -p /home/kali/.config/i3
cp ./i3/config /home/kali/.config/i3/config

mkdir -p /home/kali/.local/share/navi/cheats
cp ./navi/* /home/kali/.local/share/navi/cheats/

mkdir -p /home/kali/.config/lf
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfrc.example -o /home/kali/.config/lf/lfrc
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.sh -o /home/kali/.config/lf/lfcd.sh

echo "
LFCD=\"/home/kali/.config/lf/lfcd.sh\"
if [ -f \"\$LFCD\" ]; then
    source \"\$LFCD\"
fi
alias lf='lfcd'" >> /home/kali/.zshrc

echo "
set drawbox" >> /home/kali/.config/lf/lfrc
