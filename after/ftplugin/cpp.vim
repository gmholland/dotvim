" Indenting
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
if has('cindent')
  " indent according to geosoft style guide
  setlocal cinoptions=(0,l1,N-s,g0
endif

" Folding
setlocal foldmethod=syntax
setlocal foldlevel=0
setlocal foldcolumn=1

" vim:set ft=vim et sw=2:
