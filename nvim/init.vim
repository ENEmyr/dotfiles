if &compatible
	set nocompatible " Be iMproved
endif
set encoding=utf-8
set number relativenumber
" Enable autocompletion
set wildmode=longest,list,full
" Splits open at bottom and right, unlike vim default
set splitbelow splitright
set list
set clipboard=unnamed
let mapleader = " "

" ---------------------------------- "
" Plugins Configuration
" default path should be $HOME/.config/nvim/< ... >
" ---------------------------------- "

" Load Plugins
source ./vim-plug/plugins.vim

source ./plug-config/nerdtree.vim
source ./plug-config/airline.vim
source ./plug-config/indent-line.vim
source ./plug-config/fzf.vim
source ./plug-config/easy-fuzzy-motion.vim
source ./plug-config/rainbow-parentheses.vim
source ./plug-config/gitgutter.vim
source ./plug-config/coc.vim

" Load Theme
source ./theme.vim

" ---------------------------------- "
" Fixes mouse issues using Alacritty
" ---------------------------------- "
if has("mouse_sgr")
	set ttymouse=sgr
end

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ---------------------------------- "
" Neovide Configuration
" ---------------------------------- "
let g:neovide_refresh_rate=144
let g:neovide_transparency=0.9
" let g:neovide_fullscreen=v:true
let g:neovide_cursor_vfx_mode="wireframe" " railgun, torpedo, pixiedust, sonicboom, ripple, wireframe

" ---------------------------------- "
" Other Stuff
" ---------------------------------- "
set guifont=CascadiaCode\ NF:h14
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
" Removes pipes | that act as seperators on splits
set fillchars+=vert:\ 
" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
