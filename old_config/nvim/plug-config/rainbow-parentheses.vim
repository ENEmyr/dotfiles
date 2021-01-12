" ---------------------------------- "
" Config Rainbow parentheses
" ---------------------------------- "

let g:rainbow#max_level = 16 " how depth parentheses to be colorized
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" This plugin can affect to all file type, autocmd FileType python javascript ...
autocmd FileType * RainbowParentheses
