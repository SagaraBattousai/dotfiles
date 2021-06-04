" Apache v2 Licence combined with GPLv3 Licence code
" Resulting in GPLv3 Licence

setlocal indentexpr=CMakeGetIndent(v:lnum) "  GetCaloCMakeIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetCaloCMakeIndent(lnum)

  " Trust deindent by user after Project statement
  let plnum = prevnonblank(v:lnum - 1)
    if plnum != 0 && getline(plnum) =~ ').*'
      call cursor(plnum, col(1))
      let ppair = searchpair('(', '', ')', 'b') "'nbW',
      if ppair != 0
        if getline(ppair) =~ '^\s*\(project\|PROJECT\)\>'
          " See if the user has already dedented
          if indent(a:lnum) > indent(plnum) - shiftwidth()
            " If not, recommend one dedent
            return indent(plnum) - shiftwidth()
          endif
          " Otherwise, trust the user
          return -1
        endif
      endif
    endif
  
  " Delegate the rest to the original function.
  return CMakeGetIndent(a:lnum)

endfunction




