#!/usr/bin/fish

# Fish is not being a POSIX compliant, so when we need to use a Posix scipt just run sh -c '...'

# Set Neovim as default editor
export EDITOR="$HOME/.local/bin/lvim"
export VISUAL="$HOME/.local/bin/lvim"
# Set Alacritty as default term
export TERM=kitty
export BAT_THEME='Coldark-Dark'
# Set Configuration for nnn
set --export NNN_FIFO "/tmp/nnn.fifo"
export NNN_TMPFILE="/tmp/nnn"
export NNN_TRASH=1 # need trash-cli
export NNN_PLUG="z:autojump;c:fzcd;f:fzopen;t:preview-tui-ext;u:getplugs;m:-mediainf;s:suedit;w:wall;g:gpg;k:pskill;d:dragdrop;p:rsynccp;b:nbak;j:patchgen"
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
export TERMINAL=kitty
export TMPDIR="/tmp"
export TEMP="/tmp"
export GUI=1
export TERMINFO=/usr/lib/terminfo

fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin

set -xg PYTHONDONTWRITEBYTECODE 1

fish_vi_key_bindings
function fish_greeting
    #neofetch
    alsi
	nvm use node >> /dev/null 2>&1 # Use Node at startup
	# Apply pywal color scheme to alacritty
	#cat ~/.cache/wal/sequences &
	#neofetch --w3m ~/Pictures/Wallpapers/19.png --loop --crop_mode fit
end

# Load nvm
function nvm
	bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# abbreviations
# abbr lock "sh ~/Scripts/lock.sh"
abbr lockset "betterlockscreen --dim 40 --blur 0.8 --display 1 -u ~/Pictures/Wallpapers/EnGkmKCVcAE8ulC.jpg --time-format '%H:%M:%S' --show-layout"
abbr lock "betterlockscreen --lock"
abbr scg "$EDITOR ~/.config/fish/config.fish"
abbr dwmcg "$EDITOR ~/.config/dwm/config.def.h"
abbr awscg "$EDITOR ~/.config/awesome/rc.lua"
abbr i3cg "$EDITOR ~/.i3/config"
abbr qtcg "$EDITOR ~/.config/qtile/config.py"
abbr bscg "$EDITOR ~/.config/bspwm/bspwmrc"
abbr sxcg "$EDITOR ~/.config/sxhkd/sxhkdrc"
abbr kcg "$EDITOR ~/.config/kitty/kitty.conf"
abbr v "$EDITOR"
abbr vi "sh ~/Scripts/neovide_launcher"
abbr term "kitty"
abbr free "free -m"
abbr spacetree "ncdu"
abbr cdc "cd /mnt/CDrive"
abbr cdd "cd /mnt/DDrive"
abbr cde "cd /mnt/EDrive"
abbr r "ranger"
abbr to "touch"
abbr rwmo "sudo mount -o remount, rw /mnt/CDrive && sudo mount -o remount, rw /mnt/DDrive"
# swap caps with grave
# abbr caps "xmodmap ~/.Xmodmap &"
abbr xkb "setxkbmap -rules evdev -model pc104 -layout us,th -option grp:alt_shift_toggle &"
abbr lzg "lazygit"
abbr mixer "alsamixer"
abbr plbr "polybar-msg cmd restart"
# synchronize clock with the network
abbr clocksync "sudo ntpd -qg"
abbr lpaccaches "ll /var/cache/pacman/pkg"
abbr lparcaches "lta 2 ~/.cache/paru/clone"
abbr carlendar "calcurse"

# aliases
if type -q exa # if already have exa installed (sudo pacman -S exa)
    if git rev-parse --is-inside-work-tree &>/dev/null # if current working dir is in git repo
        alias ll "exa --long --group --header --git --icons"
        alias lt "exa --long --group --header --git --icons --tree --level $argv"
        alias lla "exa --long --all --group --header --git --icons"
        alias lta "exa --long --all --group --header --git --icons --tree --level $argv"
    else
        alias ll "exa --long --group --header --icons"
        alias lt "exa --long --group --header --icons --tree --level $argv"
        alias lla "exa --long --all --group --header --icons"
        alias lta "exa --long --all --group --header --icons --tree --level $argv"
    end
end
if type -q bat
	alias cat "bat" # bat is the smarter cat with syntax highlighting
end
alias cl "clear"
if type -q zoxide
    zoxide init fish | source
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init fish' !!
status is-interactive && eval /opt/miniconda3/condabin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Setting completion for Kitty terminal
if type -q kitty
    kitty + complete setup fish | source
end

alias n 'nnn -x -c -P t'
alias spt 'sh ~/Scripts/spt.sh'
alias memo 'obsidian'
alias dwmcomp 'sudo rm ~/.config/dwm/config.h && sudo make install'

#Recent Installed Packages
alias rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#iso and version used to install ArcoLinux
alias iso "cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

#Cleanup orphaned packages
alias cleanup 'sudo pacman -Rns $(pacman -Qtdq)'
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
