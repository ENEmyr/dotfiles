# Run Neofetch
neofetch --gtk2 off --gtk3 off --ascii_distro Arch --refresh_rate on --kernel_shorthand off --memory_percent on --cpu_temp C
# Run Alsi for performance
# alsi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory for store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

export KEYTIMEOUT=1
export GPG_TTY=$(tty)
if [ ! -z $BM_DIR ]; then
    cd -P $BM_DIR &&
    export BM_DIR=""
fi

export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/Applications/pycharm-2024/bin:$PATH"
export EDITOR="/bin/nvim"
export SUDO_EDITOR="/bin/nvim"
export VISUAL="$HOME/.local/bin/lvim"
export TERM=kitty
export TERMINAL=kitty
export BAT_THEME="Coldark-Dark"
# Set Configuration for nnn
export NNN_FIFO="$HOME/.tmp/nnn.fifo"
export NNN_TMPFILE="$HOME/.tmp/nnn"
export NNN_TRASH=1 # need trash-cli
export NNN_PLUG="z:autojump;c:fzcd;f:fzopen;t:preview-tui-ext;u:getplugs;m:-mediainf;s:suedit;w:wall;g:gpg;k:pskill;d:dragdrop;p:rsynccp;b:nbak;j:patchgen"
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
export TMPDIR="$HOME/.tmp"
export TEMP="$HOME/.tmp"
export GUI=1
export TERMINFO=/usr/lib/terminfo

export PYTHONDONTWRITEBYTECODE=1

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent agent-forwarding yes

# Download Zinit, if it's not there yet

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Use Starship as prompt
# eval "$(starship init zsh)"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
# Load with old method
# zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::command-not-found

# Load completions (Old method)
# autoload -Uz compinit && compinit
# zinit cdreplay -q

# Use Turbo for async loading for performance load
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab \
    OMZP::ssh-agent \
    OMZP::git \
    OMZP::archlinux \
    OMZP::command-not-found \
    OMZP::colored-man-pages \
    OMZP::encode64 \
    OMZP::extract \

zinit snippet OMZP::sudo

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
# Kitty shell integration
# [ -x "$(command -v kitty)" ] && kitty + complete setup zsh | source
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# Load aliases
[ -f "$ZSHCFG/aliasrc" ] && source "$ZSHCFG/aliasrc"

# Register thefuck alias
[[ ! -a $ZSH_CACHE_DIR/thefuck ]] && thefuck --alias > $ZSH_CACHE_DIR/thefuck
source $ZSH_CACHE_DIR/thefuck

# Load keybindings
[ -f "$ZSHCFG/keybinds" ] && source "$ZSHCFG/keybinds"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/enemy/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/enemy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/enemy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/enemy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
