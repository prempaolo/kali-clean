#!/usr/bin/sh

dpkg -s lf &> /dev/null
if [ $? -ne 0 ]
        then
		sudo apt install lf
fi

mkdir -p ~/.config/lf
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
