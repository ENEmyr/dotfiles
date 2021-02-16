#!/usr/bin/bash

yay -Sy ttf-iosevka

sudo chmod 555 OTF/
sudo chmod 555 TTF/

cp -rf OTF/ /usr/share/fonts
cp -rf TTF/ /usr/share/fonts

cp -rf OTF/ ~/.local/share/fonts
cp -rf TTF/ ~/.local/share/fonts

sudo fc-cahce
