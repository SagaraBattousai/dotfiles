"Start Pathogen Plugin Manager
execute pathogen#infect()


syntax on
set number
set expandtab
set smarttab
set shiftwidth=2
filetype indent on
filetype on
filetype plugin on


" Start nerdtree when vim starts if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd vimenter * if argc()==0 && !exists("s:std_in") | NERDTree | endif

" Start and close NerdT.
nmap <C-n> :NERDTreeToggle<CR>

" close vim if only window left is NerdT.
autocmd bufenter * if (winnr("$")==1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
"   set t_Co=256
" endif


nmap <Enter> o<Esc>

map j gj
map k gk
