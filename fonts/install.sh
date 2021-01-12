#!/usr/bin/bash

yay -Sy ttf-iosevka

cp -r OTF/ /usr/share/fonts

sudo fc-cahce
