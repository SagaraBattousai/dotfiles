
" .ixx (C++20 module interface) file
    if exists("did_load_filetypes")
        finish
    endif
    augroup filetypedetect
        au! BufRead,BufNewFile *.ixx setfiletype cpp
    augroup END
