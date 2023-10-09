setlocal tabstop=4

setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

set cc=89

" au BufWritePre *.py call CocActionAsync('format') " are we sure of async

"removed Ale for now
"===================
"== Ale Settings ===
"===================

" let b:ale_fixers = {'python': ['black']}

" May need to add: -> let b:ale_disable_lsp = 1
" Then it may need to be g (for global)





