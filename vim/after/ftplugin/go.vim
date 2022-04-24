
set cc=81


" Not we may prefer menueone but I dont think so
" Why does omnicomplete sometimes delete my selection?
set completeopt=longest,menu

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" au filetype go inoremap <buffer> <C-Space> <C-x><C-o>
" May want to set for every filetype
inoremap <C-Space> <C-x><C-o>

" Use popup window for Go Doc stuff
let g:go_doc_popup_window = 1

" or nnoremap ??
nmap <leader>b <Plug>(go-build)
nmap <leader>r <Plug>(go-run)

" for dealing with error plains etc
map <C-p> :cnext<CR>
map <C-o> :cprevious<CR>

" map <C-#> :lnext<CR>
" map <C-'> :lprevious<CR>
