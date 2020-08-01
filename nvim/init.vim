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
"set listchars=tab:\|\- " Set Indent line
set clipboard=unnamed
let mapleader = " "

" Load Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" ---------------------------------- "
" Plugins Configuration
" ---------------------------------- "

" ---------------------------------- "
" Config NERDTree
" ---------------------------------- "
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

" ---------------------------------- "
" Config Kite
" ---------------------------------- "
let g:kite_supported_languages = ['python', 'javascript'] " Set support languages
let g:kite_tab_complete = 1 " Use tab to complete
" Map gK to show examples and docs for the code under the cursor
nmap <silent> <buffer> gK <Plug>(kite-docs)
"set completeopt+=preview " Show docs in the preview window
"autocmd CompleteDone * if !pumvisible() | pclose | endif " Close preview window once completion has been inserted

" ---------------------------------- "
" Config Airline Powerline
" ---------------------------------- "
let g:airline_powerline_fonts = 1 " Enable Powerline font
let g:airline#extensions#tabline#enabled = 1 " Enable Tabline

" ---------------------------------- "
" Config Indentline
" ---------------------------------- "
let g:indentLine_enabled = 1

" ---------------------------------- "
" Config FZF
" ---------------------------------- "
" Map <C-p> to use Fuzzy finder (Files)
nmap <C-p> :Files<CR>
