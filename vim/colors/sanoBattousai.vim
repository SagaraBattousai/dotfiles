" ==========================================================================="
" sanoBattousai
" 
" URL: https://github.com/SagaraBattousai/sanoBattousai
" Author: James
" License: MIT
" Last Change: 2019/02/13 10:31
" ==========================================================================="

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="sanoBattousai"

"============================================================================="
"===========================sanoBattousai Colours============================="
"============================================================================="
"   Colour Name [Gui True Colour, Cterm Closest Colour] Closest Colour in Hex "
"   In Windows Terminal Order. Comments are in reference to windows terminal
"
let g:gui_background  =  "#2C3E50"       "44:62:80
let g:black           = ["#222F3E", 235] "34:47:62
let g:blue            = ["#5f87ff", 69]  "95:135:255
let g:light_black     = ["#576574", 60]  "87:101:116
let g:light_blue      = ["#54A0FF", 75]  "84:160:255
let g:light_cyan      = ["#48DBFB", 81]  "72:219:251
let g:light_green     = ["#1DD1A1", 43]  "29:209:161
let g:light_purple    = ["#D75FFF", 171] "215:95:255
let g:light_red       = ["#FF5F87", 204] "255:95:135
let g:light_gray      = ["#C8D6E5", 189] "foreground/brightWhite 200:214:229
let g:light_orange    = ["#FECA57", 221] "brightYellow 254:202:87
let g:cyan            = ["#0ABDE3", 38]  "10:189:227
let g:green           = ["#10AC84", 36]  "16:172:132
let g:purple          = ["#AF5FFF", 135] "175:95:255
let g:red             = ["#FF5F5F", 203] "255:95:95
let g:gray            = ["#8395A7", 103] "white 131:149:167
let g:orange          = ["#FF9F43", 214] "yellow 255:159:67
"Remaining colours don't have a windows terminal version
let g:white           = ["#FFFFFF", 15]  "255:255:255
let g:light_pink      = ["#FF9FF3", 219] "255:159:243
let g:pink            = ["#FF87FF", 213] "255:135:255
let g:light_turquoise = ["#00D2D3", 80]  "0:210:211
let g:turquoise       = ["#01A3A4", 37]  "1:163:164
let g:comment         = ["#D7AFFF", 183] "215:175:255
let g:None            = ["NONE", "NONE"]
"============================================================================="
"===========================sanoBattousai Styles=============================="
"============================================================================="
let g:bold          = "bold"
let g:italic        = "italic"
let g:underline     = "underline"
let g:strikethrough = "strikethrough"
let g:inverse       = "inverse"
let g:override      = "nocombine"
let g:empty         = "NONE"
"============================================================================="
"===========================Colour Setting Function==========================="
"============================================================================="
function! SetColours(group, fg, ...)
 
  let hi_string = 'hi ' . a:group . ' '

  if len(a:fg)
    let hi_string .= 'guifg=' . a:fg[0] . ' ctermfg=' . a:fg[1] . ' '
  else
    let hi_string .= 'guifg=NONE ctermfg=NONE '
  endif

  if a:0 >= 1 && len(a:1)
    let hi_string .= 'guibg=' . a:1[0] . ' ctermbg=' . a:1[1] . ' '
  else
    let hi_string .= 'guibg=' . g:gui_background . ' ctermbg=NONE '
  endif

  if a:0 >= 2
    let hi_string .= 'gui=' . join(a:000[1:], ",") . ' cterm=' . join(a:000[1:], ",") . ' '
  endif   

  execute hi_string
endfunction
"============================================================================"
"==========================VIM HIGHLIGHTING GROUPS==========================="
"============================================================================"
call SetColours("Normal", g:light_gray)

call SetColours("LineNr", g:blue)

call SetColours("ModeMsg", g:light_orange)
	 
call SetColours("Cursor", g:purple, g:white)
	
call SetColours("Visual", g:blue, g:black)

call SetColours("WildMenu", g:orange, g:blue)

call SetColours("NonText", g:blue)

call SetColours("MatchParen", g:light_cyan, g:blue)

call SetColours("VertSplit", g:blue, g:light_cyan)

call SetColours("Search", g:light_blue) "g:blue, g:light_blue)

call SetColours("WarningMsg", g:orange)

call SetColours("ErrorMsg", g:light_red)

call SetColours("Question", g:light_blue)

call SetColours("StatusLine", g:blue)

call SetColours("IncSearch", g:light_turquoise)

call SetColours("Title", g:orange)

call SetColours("Directory", g:blue)

call SetColours("DiffAdd", g:light_green)

call SetColours("DiffChange", g:blue)

call SetColours("DiffDelete", g:light_red)

call SetColours("DiffText", g:light_orange)

call SetColours("Folded", g:blue)

call SetColours("FoldColumn", g:blue)

call SetColours("ColorColumn", g:white, g:light_blue)

call SetColours("CursorColumn", g:blue)

call SetColours("SignColumn", g:light_blue)

call SetColours("CursorLine", g:blue)

call SetColours("Pmenu", g:light_orange, g:blue)

call SetColours("PmenuSel", g:light_orange, g:light_blue)

call SetColours("PmenuSbar", g:light_cyan)

call SetColours("PmenuThumb", g:light_blue)

call SetColours("SpellBad", g:light_red)

call SetColours("SpellLocal", g:light_blue)

call SetColours("SpellRare", g:blue)

call SetColours("TabLine", g:light_blue)

call SetColours("TabLineFill", g:blue)

call SetColours("TabLineSel", g:light_cyan)

call SetColours("Conceal", g:light_blue)

hi def link StatusLineNC StatusLine

hi def link VisualNOS Visual

hi def link CursorIM Cursor

"Prefered
call SetColours("Comment", g:comment)

"============================================================================"

"Prefered
call SetColours("Constant", g:light_pink)

call SetColours("String", g:light_red)

call SetColours("Character", g:orange)

call SetColours("Number", g:blue)

call SetColours("Boolean", g:light_green)

call SetColours("Float", g:cyan)

"============================================================================"

"Prefered
call SetColours("Identifier", g:light_blue)

call SetColours("Function", g:light_purple) "purple)

"============================================================================"

"Prefered
call SetColours("Statement", g:green)

call SetColours("Conditional", g:light_cyan) "if

call SetColours("Repeat", g:light_turquoise) "for

call SetColours("Label", g:blue) "case

call SetColours("Operator", g:light_green) "sizeof

call SetColours("Keyword", g:turquoise)

call SetColours("Exception", g:light_red)

"============================================================================"

"Prefered
call SetColours("PreProc", g:pink)

call SetColours("Include", g:light_purple)

call SetColours("Macro", g:purple)

hi link Define Macro

call SetColours("PreCondit", g:light_pink)

"============================================================================"

"Prefered
call SetColours("Type", g:light_blue, [], g:override)

call SetColours("StorageClass", g:light_cyan)

call SetColours("Structure", g:green)

call SetColours("Typedef", g:light_green) "new in Java but not c

"============================================================================"

"Prefered
call SetColours("Special", g:light_cyan)

call SetColours("SpecialChar", g:light_cyan)

call SetColours("Tag", g:pink)

call SetColours("Delimiter", g:blue) "( and ) in vimscript.

call SetColours("SpecialComment", g:light_purple)

call SetColours("Debug", g:purple)

"============================================================================"

"Prefered
call SetColours("Underlined", g:light_cyan) "Like HTML Links etc

"============================================================================"

"Prefered
call SetColours("Ignore", g:light_pink)

"============================================================================"

"Prefered
call SetColours("Error", g:light_blue, g:red, g:strikethrough)

"============================================================================"

"Prefered                             g:light_blue
call SetColours("Todo", g:light_pink, g:None, g:bold, g:underline)

"============================================================================"

