" ALE Settings
"
let b:ale_linters = {'haskell': ['hls', 'cabal_ghc']}

" let b:ale_fixers = {'haskell': ['ormolu', 'hlint']}
let b:ale_fixers = {'haskell': ['ormolu']}

" let b:ale_haskell_ormolu_options = \"--mode inplace"

let b:ale_disable_lsp = 1

" nnoremap tf :call RunOrmolu()<CR>


