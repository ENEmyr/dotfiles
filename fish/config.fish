#!/usr/bin/fish

# Fish is not being a POSIX compliant, so when we need to use a Posix scipt just run sh -c '...'

# Set Neovim as default editor
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
# Set Alacritty as default term
export TERM=kitty
export BAT_THEME='Coldark-Dark'

set -xg PYTHONDONTWRITEBYTECODE 1


fish_vi_key_bindings
function fish_greeting
    neofetch
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
abbr lock "sh ~/Scripts/lock.sh"
abbr scg "nvim ~/.config/fish/config.fish"
abbr awscg "nvim ~/.config/awesome/rc.lua"
abbr i3cg "nvim ~/.i3/config"
abbr qtcg "nvim ~/.config/qtile/config.py"
abbr bscg "nvim ~/.config/bspwm/bspwmrc"
abbr sxcg "nvim ~/.config/sxhkd/sxhkdrc"
abbr kcg "nvim ~/.config/kitty/kitty.conf"
abbr v "$EDITOR"
abbr vi "sh ~/Application/neovide_launcher"
abbr term "alacritty"
abbr free "free -m"
abbr cdc "cd /mnt/WindowsC"
abbr cdd "cd /mnt/WindowsD"
abbr cde "cd /mnt/WindowsE"
abbr r "ranger"
abbr to "touch"
abbr rwmo "sudo mount -o remount, rw /mnt/WindowsE && sudo mount -o remount, rw /mnt/WindowsD && sudo mount -o remount, rw /mnt/WindowsC"
# swap caps with grave
abbr caps "xmodmap ~/.Xmodmap &"
abbr xkb "setxkbmap -rules evdev -model pc104 -layout us,th -option grp:alt_shift_toggle &"
abbr lzg "lazygit"
abbr mixer "alsamixer"
abbr memo "nvim ~/Documents/Memo.wiki"
abbr plbr "polybar-msg cmd restart"
# synchronize clock with the network
abbr clocksync "sudo ntpd -qg"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init fish' !!
status is-interactive && eval /home/enemy/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Setting completion for Kitty terminal
if type -q kitty
    kitty + complete setup fish | source
end
