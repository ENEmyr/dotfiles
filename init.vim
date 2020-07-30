if &compatible
	set nocompatible " Be iMproved
endif

set encoding=utf-8
set rnu
set list
set listchars=tab:\|\-
set clipboard=unnamed
let mapleader = " "

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

" Disable
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Config Kite
let g:kite_supported_languages = ['python', 'javascript'] " Set support languages
let g:kite_tab_complete = 1 " Use tab to complete
" Map gK to show examples and docs for the code under the cursor
nmap <silent> <buffer> gK <Plug>(kite-docs)
"set completeopt+=preview " Show docs in the preview window
"autocmd CompleteDone * if !pumvisible() | pclose | endif " Close preview window once completion has been inserted

" Config NERDTree
map <Leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Auto toggle NERDTree at current directory when open vim inside workspace or working directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd'.argv()[0] | endif
" Auto toggle NERDTree when open vim without a file like ' vim '
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim when have no any tab except NERDTree and current tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Config Airline Powerline
let g:airline_powerline_fonts = 1
