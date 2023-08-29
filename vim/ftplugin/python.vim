setlocal tabstop=4

setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

set cc=81

"===================
"== Ale Settings ===
"===================

let b:ale_fixers = {'python': ['black']}
let b:ale_python_black_options = '--line-length=80'

" May need to add: -> let b:ale_disable_lsp = 1
" Then it may need to be g (for global)





