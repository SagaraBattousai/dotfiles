" Copyright 2019 Google LLC
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"    https://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif


  " JAMES CUSTOM INDENT WITH MULTILINE RETURN
  if getline(v:lnum) =~ '^\s*\(def\|if\|class\|while\|for\|try\)\>'
    
    let plnum = prevnonblank(v:lnum - 1)

    if plnum != 0
      call cursor(plnum, 1)
      let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'b') "'nbW',
      if pp != 0
        "if getline(pp) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
        if getline(pp) =~ '^\s*return\>'
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
  endif



  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
