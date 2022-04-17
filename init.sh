#!/bin/sh

# Initialize system

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

configgit() {
    git config --global github.user untesler
    git config --global user.name ENEmy
    git config --global user.email nosde@protonmail.com
}

installlvim() {
    echo 'Installing Lvim'
    sudo npm install -g tree-sitter-cli pyright bash-language-server prettier --force
    sudo luarocks install --server=https://luarocks.org/dev luaformatter
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
    cp $dotpath'/lvim/config.lua' $HOME'/.config/lvim'
}

initsshgithub() {
    echo 'Initializing SSH for Github'
    echo -n 'Enter email : '
    read email
    ssh-keygen -t ed25519 -C $email
    echo -n 'Enter SSH private key path : '
    read sshpath
    eval "$(ssh-agent -s)"
    ssh-add $sshpath
    xclip -selection clipboard < $sshpath'.pub'
    answer='n'
    while [ "$answer" != "y" ]; do
        echo -n 'Is you already put your public key into Github (y/n)? : '
        read answer
    done
}

installminiconda3() {
    # TODO: Seperate this func into another script because need to restart the terminal to take affect after installing conda
    echo 'Installing Anaconda3'
    if [ -x "$(command -v conda)" ]; then
      echo 'Miniconda3 is already installed!'
      sudo conda update -n base -c defaults conda --yes
      # Install necessary packages
      pip install neovim-remote pynvim ueberzug sphinx meson
      sudo pacman -S python-pywal --needed --noconfirm
    else
      paru -S miniconda3 --needed --noconfirm
      [ -d "/opt/miniconda3/bin" ] && /opt/miniconda3/bin/conda init
    fi
}

installmariadb() {
    # TODO: Seperate this func into another script because need to restart the terminal to take affect after installing conda
    echo 'Installing MariaDB'
    if [ -x "$(command -v mysql)" ]; then
      echo 'MariaDB is already installed!'
    else
      paru -S mariadb --needed --noconfirm
      # disable copy-on-write for btfs file system
      sudo chattr +C /var/lib/mysql/
      sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
      systemctl enable --now mariadb
      sudo mysql_secure_installation
    fi
}

sudo pwd
echo 'Initializing System'

answer='n'
while [ "$answer" == "n" ]; do
    echo -n 'Please enter path to dotfiles/ (like: /home/enemy/Repositories/dotfiles) : '
    read dotpath
    echo 'Are your sure "'$dotpath'" is the path you want (y/n)? '
    read answer
    [ ! -d "$dotpath" ] && echo $dotpath 'not found.' && answer='n'
done

# If not have these folders, then create 
[ ! -d "$HOME/Scripts" ] && mkdir $HOME'/Scripts'
[ ! -d "$HOME/Downloads/Torrents" ] && mkdir -p  $HOME'/Downloads/Torrents'
[ ! -d "$HOME/Pictures/Wallpapers" ] && mkdir -p $HOME'/Pictures/Wallpapers'
[ ! -d "$HOME/Pictures/Avatars" ] && mkdir -p $HOME'/Pictures/Avatars'
[ ! -d "$HOME/Application" ] && mkdir $HOME'/Application'
[ ! -d "$HOME/Repositories" ] && mkdir $HOME'/Repositories'

sudo pacman -Syu

echo 'Installing packages'
# maybe need to add more in order to build a picom with mesa
sudo pacman -S base-devel nvidia-dkms pkg-config boost git feh catdoc pandoc glibc cmake wget fish fzf go rust lua jre-openjdk jdk-openjdk jq neofetch vim nodejs npm luarocks meson nvidia-settings python-sphinx ranger rofi alsa tree-sitter unoconv xclip xsel zathura zathura-cb zathura-djvu zathura-pdf-mupdf ripgrep uthash mesa check fd firefox libev xcb-util libxcb libconfig dbus dunst keepassxc ufw rtorrent exa bat kitty rsync dragon mediainfo tree sxiv sxhkd trash-cli playerctl calcurse ncdu xfce-polkit --needed --noconfirm
configgit

echo 'Installing Paru for managing AUR packages'
if ! command -v paru &> /dev/null; then
	git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si
	cd .. && sudo rm -rf paru
fi
echo 'Installing packages from AUR'
# comment out: spotify, spotifyd-runit
paru -S alacritty audacity discord obs-studio flameshot neovim python-ueberzug-git lazygit gnome-disk-utility microsoft-edge-dev-bin  neovide spotifyd spotify-tui-bin translate-shell zoxide-bin nnn-nerd python-pynvim drive-git tty-clock alsi gotop-bin nvtop volumeicon imagemagick xdotool xkblayout-state --needed
[ ! -d "$HOME/.nvm" ] && cd $HOME && git clone https://github.com/nvm-sh/nvm.git .nvm

cp -rf $dotpath'/ranger' $HOME'/.config'
cp -rf $dotpath'/alacritty' $HOME'/.config'
cp -rf $dotpath'/kitty' $HOME'/.config'
cp -rf $dotpath'/nnn' $HOME'/.config'
cp -rf $dotpath'/dunst' $HOME'.config'
cp -rf $dotpath'/spotifyd' $HOME'/.config'
cp -rf $dotpath'/keepmenu/.config/keepmenu' $HOME'/.config'
cp -rf $dotpath'/.moc' $HOME
cp -rf $dotpath'/Pictures' $HOME
cp $dotpath/.tmux.conf $HOME
cp $dotpath/.rtorrent.rc $HOME

sudo ln -s "$HOME/Scripts/firefox_playerctl_notifier" /usr/bin/firefox_playerctl_notifier
sudo ln -s "$HOME/Scripts/mocp_notifier" /usr/bin/mocp_notifier
sudo ln -s "$HOME/Scripts/dmenu-translate" /usr/bin/dmenu-translate
echo 'Installing fonts'

paru -Sy ttf-iosevka --needed

sudo chmod 555 $dotpath'/fonts/OTF/'
sudo chmod 555 $dotpath'/fonts/TTF/'

sudo cp -rf $dotpath'/fonts/OTF/' /usr/share/fonts
sudo cp -rf $dotpath'/fonts/TTF/' /usr/share/fonts

[ ! -d "$HOME/.local" ] && mkdir $HOME/.local
[ ! -d "$HOME/.local/share" ] && mkdir $HOME/.local/share
[ ! -d "$HOME/.local/share/fonts" ] && mkdir $HOME/.local/share/fonts

sudo cp -rf $dotpath'/fonts/OTF/' $HOME/.local/share/fonts
sudo cp -rf $dotpath'/fonts/TTF/' $HOME/.local/share/fonts

sudo fc-cache

echo -n "Would you like to swap CapsLock key with Grave(~,\`) key (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && cp $dotpath'/.Xmodmap' $HOME

echo -n "Would you like to install Miniconda3 now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installminiconda3
[ "$answer" != "${answer#[Nn]}" ] && pip install neovim-remote pynvim ueberzug sphinx meson keepmenu && sudo pacman -S python-pywal --needed --noconfirm

echo -n "Would you like to install MariaDB (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installmariadb

echo 'Installing Fish packages'
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
cat $dotpath/fish/fish_plugins | \
    while read package; do
        fish -c 'fisher install '$package
    done
cp $dotpath'/fish/config.fish' $HOME'/.config/fish'
chsh -s `which fish`

echo -n "Would you like to install ENEv now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installlvim

echo -n "Would you like to initialize ssh for github now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && initsshgithub
