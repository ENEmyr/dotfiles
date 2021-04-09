#!/usr/bin/sh

echo 'Installing fonts'

paru -Sy ttf-iosevka

sudo chmod 555 OTF/
sudo chmod 555 TTF/

sudo cp -rf OTF/ /usr/share/fonts
sudo cp -rf TTF/ /usr/share/fonts

[ ! -d "$HOME/.local" ] && mkdir $HOME/.local
[ ! -d "$HOME/.local/share" ] && mkdir $HOME/.local/share
[ ! -d "$HOME/.local/share/fonts" ] && mkdir $HOME/.local/share/fonts

sudo cp -rf OTF/ $HOME/.local/share/fonts
sudo cp -rf TTF/ $HOME/.local/share/fonts

sudo fc-cache
