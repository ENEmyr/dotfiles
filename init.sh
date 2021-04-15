#!/bin/sh

# Initialize system

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

configgit() {
    git config --global github.user untesler
    git config --global user.name ENEmy
    git config --global user.email nosde@protonmail.com
}

installnvcode() {
    echo 'Installing NVcode'
    sudo npm install -g tree-sitter-cli pyright bash-language-server prettier
    luarocks install --server=https://luarocks.org/dev luaformatter
    bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/installer/install.sh)
    # Patch my own config
    cp -rf $dotpath'/patch_nvcode/*' $HOME'/.config/nvim/'
}

initsshgithub() {
    echo 'Initializing SSH for Github'
    echo -n 'Enter email : '
    read email
    ssh-keygen -t ed25519 -C $email
    eval "$(ssh-agent -s)"
    echo -n 'Enter SSH private key path : '
    read sshpath
    ssh-add sshpath
    xclip -selection clipboard < sshpath'.pub'
    while [ "$answer" != "y" ]; do
        echo -n 'Is you already put your public key into Github (y/n)? : '
        read answer
    done
}

installpicom() {
    git clone https://github.com/ibhagwan/picom.git
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
    cd .. && rm -rf picom
    cp -rf $dotpath'/picom' $HOME'/.config'
}

installpolybarthemes() {
    git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
    cd polybar-themes
    sudo chmod +x setup.sh
    sh setup.sh
    cd ..
    rm -rf polybar-themes
    cp $dotpath'/polybar/launch.sh' $HOME'/.config/polybar'
    cp -rf $dotpath'/polybar/custom_modules' $HOME'/.config/polybar'
    cp -rf $dotpath'/polybar/colorblocks' $HOME'/.config/polybar'
}

installanaconda() {
    echo 'Installing Anaconda3'
    if [ -x "$(command -v conda)" ]; then
      echo 'Anaconda is already installed!'
    else
      # Scrape the latest Anaconda
      anaconda_url=$(wget -O - https://www.anaconda.com/distribution/ 2>/dev/null | sed -ne 's@.*\(https:\/\/repo\.anaconda\.com\/archive\/Anaconda3-.*-Linux-x86_64\.sh\)\">64-Bit (x86) Installer.*@\1@p')
      [ $anaconda_url ] && curl -L $anaconda_url > anaconda_script.sh
      # If the url format is out of date just use static link instead.
      [ $anaconda_url ] || curl -L "https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh" > anaconda_script.sh
      sudo sh anaconda_script.sh
      rm anaconda_script.sh
    fi
    conda update --yes conda
    conda update --yes anaconda
    source ~/.bash_profile
    # Install necessary packages
    pip install neovim-remote pynvim ueberzug sphinx meson
}

echo 'Initializing System'

answer='n'
while [ "$answer" == "n" ]; do
    echo -n 'Please enter path to dotfiles/ (like: /home/enemy/Repos/dotfiles) : '
    read dotpath
    echo 'Are your sure "'$dotpath'" is the path you want (y/n)? '
    read answer
    [ ! -d "$dotpath" ] && echo $dotpath 'not found.' && answer='n'
done

# If not have these folders, then create 
[ ! -d "$HOME/Scripts" ] && mkdir ~/Scripts
[ ! -d "$HOME/Downloads/Torrents" ] && mkdir ~/Downloads/Torrents
[ ! -d "$HOME/Pictures/Wallpapers" ] && mkdir ~/Pictures/Wallpapers
[ ! -d "$HOME/Pictures/Avatars" ] && mkdir ~/Pictures/Avatars
[ ! -d "$HOME/Application" ] && mkdir ~/Application
[ ! -d "$HOME/Repos" ] && mkdir ~/Repos

sudo pacman -Syu
# rsm is for runit service manager
echo -n "Would you like to install rsm(runit services manager) now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && sudo pacman -S rsm

echo 'Installing packages'
# maybe need to add more in order to build a picom with mesa
sudo pacman -S base-devel pkg-config boost git feh xautolock catdoc pandoc cmake wget fish fzf go rust lua jre-openjdk jdk-oprenjdk jq neofetch vim nodejs npm luarocks meson nvidia-dkms nvidia-settings python-sphinx ranger rofi alsa tree-sitter ueberzug unoconv xclip xsel zathura zathura-cb zathura-djvu zathura-pdf-mupdf ripgrep uthash mesa check fd firefox libev xcb-util libxcb libconfig dbus dunst keepassxc ufw rtorrent --needed --noconfirm
configgit

echo 'Installing Paru for managing AUR packages'
git clone https://aur.archlinux.org/paru.git
cd paru && sudo makepkg -si
cd .. && sudo rm -rf paru
echo 'Installing packages from AUR'
paru -S alacritty audacity discord spotify obs-studio flameshot nvm neovim-nightly-git moc-pulse-svn python-ueberzug-git polybar-git lazygit gnome-disk-utility microsoft-edge-dev-bin mpc-qt-git neovide-git spotifyd spotifyd-runit spotify-dev spotify-tui drive-git --needed --noconfirm

cp -rf $dotpath'/bspwm' $HOME'/.config'
cp -rf $dotpath'/ranger' $HOME'/.config'
cp -rf $dotpath'/alacritty' $HOME'/.config'
cp -rf $dotpath'/sxhkd' $HOME'/.config'
cp -rf $dotpath'/.moc' $HOME
cp $dotpath/.tmux.conf $HOME
cp $dotpath/.rtorrent.rc $HOME
sh $dotpath'/fonts/install.sh'
echo -n "Would you like to swap CapsLock key with Grave(~,\`) key (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && cp $dotpath'/.Xmodmap' $HOME
echo -n "Would you like to make system x configuration file is usable by nvidia x driver (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && sudo nvidia-xconfig

echo -n "Would you like to install Anaconda3 now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installanaconda
[ "$answer" != "${answer#[Nn]}" ] && pip install neovim-remote pynvim ueberzug sphinx meson

echo 'Installing Fish packages'
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
cat $dotpath | \
    while read package; do
        fish -c 'fisher install '$package
    done
cp $dotpath'/fish/config.fish' $HOME'.config/fish'

echo 'Installing Polybar-Theme'
installpolybarthemes
echo 'Installing Picom'
installpicom


echo -n "Would you like to initialize ssh for github now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && initsshgithub

echo -n "Would you like to install NVcode now (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installnvcode
