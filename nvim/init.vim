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
source $HOME/AppData/Local/nvim/vim-plug/plugins.vim

" source ./plug-config/nerdtree.vim , Use nvim-tree instead
" source ./plug-config/airline.vim , Use barbar and galaxyline instead
source $HOME/AppData/Local/nvim/plug-config/indent-line.vim
source $HOME/AppData/Local/nvim/plug-config/fzf.vim
source $HOME/AppData/Local/nvim/plug-config/easy-fuzzy-motion.vim
source $HOME/AppData/Local/nvim/plug-config/rainbow-parentheses.vim
source $HOME/AppData/Local/nvim/plug-config/gitgutter.vim
source $HOME/AppData/Local/nvim/plug-config/coc.vim
source $HOME/AppData/Local/nvim/plug-config/barbar.vim
source $HOME/AppData/Local/nvim/plug-config/nvim-tree.vim
source $HOME/AppData/Local/nvim/plug-config/galaxyline.vim

" Load Theme
source $HOME/AppData/Local/nvim/theme.vim

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

" ---------------------------------- "
" Keymappings
" ---------------------------------- "

" Terminal Window Navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>

" Resize With Arrows
nnoremap <silent> <C-Up>    :resize -2<CR>
nnoremap <silent> <C-Down>  :resize +2<CR>
nnoremap <silent> <C-Left>  :vertical resize -2<CR>

" Switch Buffer
" Already set in plug-config/barbar.vim
" nnoremap <silent> <TAB> :bnext<CR>
" nnoremap <silent> <S-TAB> :bprevious<CR>

" Move Selected Line / Block of Text in Visual Mode
xnoremap <silent> <K> :move '<-2<CR>gv-gv
xnoremap <silent> <J> :move '>+1<CR>gv-gv

