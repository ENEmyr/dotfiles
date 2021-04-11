" ---------------------------------- "
" Config Airline Powerline
" ---------------------------------- "

let g:airline_powerline_fonts = 0 " Enable Powerline font
let g:airline#extensions#tabline#enabled = 0 " Enable Tabline
" Map <leader>b+number to select the tab
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>b1 <Plug>AirlineSelectTab1
nmap <leader>b2 <Plug>AirlineSelectTab2
nmap <leader>b3 <Plug>AirlineSelectTab3
nmap <leader>b4 <Plug>AirlineSelectTab4
nmap <leader>b5 <Plug>AirlineSelectTab5
nmap <leader>b6 <Plug>AirlineSelectTab6
nmap <leader>b7 <Plug>AirlineSelectTab7
nmap <leader>b8 <Plug>AirlineSelectTab8
nmap <leader>b9 <Plug>AirlineSelectTab9
