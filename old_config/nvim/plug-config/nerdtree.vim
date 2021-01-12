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
