#!/usr/bin/fish

# Fish is not being a POSIX compliant, so when we need to use a Posix scipt just run sh -c '...'

# Set Neovim as default editor
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
# Set Alacritty as default term
export TERM=alacritty

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

# alias
abbr lock "sh ~/Scripts/lock.sh"
abbr scg "nvim ~/.config/fish/config.fish"
abbr awscg "nvim ~/.config/awesome/rc.lua"
abbr i3cg "nvim ~/.i3/config"
abbr qtcg "nvim ~/.config/qtile/config.py"
abbr bscg "nvim ~/.config/bspwm/bspwmrc"
abbr sxcg "nvim ~/.config/sxhkd/sxhkdrc"
abbr v "$EDITOR"
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



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init fish' !!
status is-interactive && eval /home/enemy/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Spacefish setup
#set SPACEFISH_PROMPT_ORDER dir user host
#set SPACEFISH_RPROMPT_ORDER git node exec_time time
#set SPACEFISH_DIR_SHOW true
#set SPACEFISH_PROMPT_ADD_NEWLINE true
#set SPACEFISH_PROMPT_SEPARATE_LINE true
#set SPACEFISH_PROMPT_FIST_PREFIX_SHOW true
#set SPACEFISH_TIME_SHOW true
#set SPACEFISH_DATE_SHOW false
#set SPACEFISH_TIME_PREFIX  
#set SPACEFISH_USER_SHOW true
#set SPACEFISH_USER_PREFIX  
#set SPACEFISH_USER_COLOR 5fd7ff
#set SPACEFISH_DIR_PREFIX  
#set SPACEFISH_HOST_SHOW_FULL true
#set SPACEFISH_HOST_PREFIX  
#set SPACEFISH_VI_MODE_SHOW true
