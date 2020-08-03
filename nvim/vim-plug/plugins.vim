" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/autoload/plugged')

"" Install Plugin with vim-plug
Plug 'easymotion/vim-easymotion'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'yggdroot/indentline'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim' " Easy Fuzzy Search
Plug 'junegunn/rainbow_parentheses.vim' " Add rainbow parentheses
Plug 'airblade/vim-gitgutter' " Show git diff
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Semantic highlightings for Python need to install pynvim via pip see more : https://vimawesome.com/plugin/semshi
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlight in NERDTree
Plug 'ryanoasis/vim-devicons' " Provide icons for each filetypes
Plug 'francoiscabrol/ranger.vim' " Integrate Vim and Ranger, Default key to open ranger is <leader>f
Plug 'rbgrouleff/bclose.vim' " Dependencie for ranger.vim

"" Disable
""Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"
"" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
	\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | q
	\| endif
