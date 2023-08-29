
" Strings and constants
" syn match   hsSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
" syn region  hsFFIInclude      start=+(?<=capi )"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar,@NoSpell


if exists("b:hs_highlight_c_types")
  " Types from the standard prelude libraries.
  syn keyword hsCType CChar CShort CInt CLong CLLong CBool 
  syn keyword hsCType CSChar CWchar CUChar CUShort CUInt CULong CULLong
  syn keyword hsCType CSize CPtrdiff CSigAtomic CIntPtr CUIntPtr CIntMax CUIntMax  
  syn keyword hsCType CClock CTime CUSeconds CSUSeconds 
  syn keyword hsCType CFloat CDouble 
  syn keyword hsCType CFile CFpos CJmpBuf
  syn keyword hsCType CString CStringLen
  syn keyword hsCTypeClass Ptr ForeignPtr
endif

" Keyword definitions.
syn match   hsForeignFunctionGroup  "\<foreign\>.*" contains=hsForeign,hsImport,hsCAPI,hsFFIInclude,hsForeignUnsafe,@NoSpell nextgroup=hsForeign
syn keyword hsForeign		    foreign  contained nextgroup=hsImport
syn keyword hsForeignImport         import contained nextgroup=hsCAPI, hsForeignUnsafe
syn keyword hsForeignUnsafe         unsafe contained nextgroup=hsCAPI
syn keyword hsCAPI		    capi contained nextgroup=hsFFIInclude
" despite being identicle to hsString we use this here incase we want to 
" recoulour or require ...
syn region  hsFFIInclude      contained start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar,@NoSpell
" syn match   hsForeignFunctionName "\<[a-z][a-zA-Z0-9_']*\>" contained nextgroup=hsVarSym

syn keyword hsUndefined  undefined

syn keyword hsPattern pattern
" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" hi def link hsModule			  hsStructure
" hi def link hsString			  String
" hi def link hsLabel			  Special
hi def link hsFFIInclude		  hsString
hi def link hsForeign			  hsPragma 
hi def link hsForeignUnsafe		  hsLabel
" hsPragma may be better than hsLabel since it's less distracting
hi def link hsCAPI			  hsPragma  
hi def link hsCType			  hsType
hi def link hsCTypeClass		  hsType
hi def link hsUndefined			  hsEnumConst
hi def link hsPattern			  PreProc

let hs_highlight_types = 1
let hs_highlight_more_types = 1
" let hs_highlight_c_types = 1

let b:current_syntax = "haskell"

" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim
