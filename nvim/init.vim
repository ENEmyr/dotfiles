if &compatible
	set nocompatible " Be iMproved
endif
set encoding=utf-8
set guifont=CaskaydiaCove\ Nerd\ Font:h10
set number relativenumber
" Enable autocompletion
set wildmode=longest,list,full
" Splits open at bottom and right, unlike vim default
set splitbelow splitright
set list
"set listchars=tab:\|\- " Set Indent line
set clipboard=unnamed
let mapleader = " "

" Load Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" ---------------------------------- "
" Plugins Configuration
" ---------------------------------- "

source $HOME/.config/nvim/plug-config/nerdtree.vim
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/indent-line.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/easy-fuzzy-motion.vim
source $HOME/.config/nvim/plug-config/rainbow-parentheses.vim
source $HOME/.config/nvim/plug-config/gitgutter.vim
source $HOME/.config/nvim/plug-config/coc.vim

" ---------------------------------- "
" Fixes mouse issues using Alacritty
" ---------------------------------- "
if has("mouse_sgr")
    set ttymouse=sgr
end
