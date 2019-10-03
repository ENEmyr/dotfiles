set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
set encoding=utf-8
call vundle#begin()
set rnu
set list
set listchars=tab:\|\-
set clipboard=unnamed
let mapleader = " "

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'nvie/vim-flake8'
Plugin 'zxqfl/tabnine-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'roman/golden-ratio'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'easymotion/vim-easymotion'
Plugin 'w0rp/ale'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'cjrh/vim-conda'
Plugin 'sheerun/vim-polyglot'
Bundle 'Valloric/YouCompleteMe'
"Plugin 'powerline/powerline'
" ...
" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required

" ---------------------------------- "
" Configure NERDTree
" ---------------------------------- "

" Toggle NERDTree
map <Leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Auto toggle NERDTree at current directory when open vim inside workspace or working directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Auto toggle NERDTree when open vim without a file like ' vim '
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim when have no any tab except NERDTree and current tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" ---------------------------------- "
" Configure Powerline
" ---------------------------------- "

set rtp+=/home/enemy/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" ---------------------------------- "
" Configure Ultisnip and YouCompleteMe
" ---------------------------------- "

" Ultisnip = python snippet

" Ctrl+Tab for select intellisense

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

"let g:UltiSnipsExpandTrigger="<Enter>"

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ---------------------------------- "
" Configure YouCompleteMe
" ---------------------------------- "

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_autoclose_preview_window_after_completion=1
let python_highlight_all=1
syntax on
let g:ycm_key_list_select_completion = ['<Enter>', '<Down>'] " This option controls the key mappings used to select the first completion string. I
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>', '<tab>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" Goto definition with F3
map <F3> :YcmCompleter GoTo<CR>

" ---------------------------------- "
" Configure Syntastic
" ---------------------------------- "

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 1
"let g:ale_virtualenv_dir_names = []
