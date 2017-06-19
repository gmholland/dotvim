" Indenting
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
if has('cindent')
  " indent according to LLVM style guide
  setlocal cinoptions=:0,g0,(0,Ws,l1
endif

" Folding
setlocal foldmethod=syntax
setlocal foldlevel=1
setlocal foldcolumn=1

" vim:set ft=vim et sw=2:
