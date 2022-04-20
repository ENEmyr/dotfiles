#!/usr/bin/env bash 

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

# bash ~/.screenlayout/screen.sh
# bash ~/.dwm/autostart_personal.sh
wmname LG3D &
#change your keyboard if you need it
#setxkbmap -layout be
#swich around capslock and escape key
#xmodmap -e "keycode 9 = Caps_Lock"; xmodmap -e "keycode 66 = Escape" &
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
setxkbmap -rules evdev -model pc104 -layout us,th -option grp:alt_shift_toggle &
killall mocicon
mocicon &
killall volumeicon
volumeicon &
nitrogen --restore &
xsetroot -cursor_name left_ptr &
nm-applet &
numlockx on &
# uncomment the 3 lines below to start bluetooth on boot
#killall blueberry
#killall blueberry-tray
#blueberry-tray &
killall picom
picom --experimental-backends --config $HOME/.config/enemy-dwm/picom.conf &
killall polkit-gnome-au
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
killall dunst
exec dunst &
xset r rate 350 60 &
killall dwmblocks
dwmblocks &
killall sxhkd
sxhkd -c $HOME/.config/enemy-dwm/sxhkdrc &
# killall betterlockscreen
# betterlockscreen -u $(cat ~/.config/nitrogen/bg-saved.cfg | grep file | sed 's/file=//g') &

run "pamac-tray"
run "variety"
run "xfce4-power-manager"
run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run slstatus &
feh --bg-fill $HOME/Pictures/Wallpapers/laplus_bg_2.png &
