#!/bin/bash

ws=

i3-msg "workspace $ws; append_layout $HOME/.config/i3/enemy-workspace.json"

sleep .1
i3-msg exec "alacritty"
sleep .5
i3-msg exec "alacritty"
sleep .5
i3-msg exec "alacritty"
sleep .5
#i3-msg exec "workspace $ws; exec alacritty -e zsh -c 'screenfetch && zsh'"
#sleep .5
#i3-msg exec "workspace $ws; exec alacritty -e zsh -c 'ranger && zsh'"
#sleep .5
#i3-msg exec "workspace $ws; exec alacritty -e zsh -c 'bpytop && zsh'"
#sleep .5
