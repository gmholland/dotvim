if has('colorcolumn')
  setlocal colorcolumn=
endif

if has('folding')
  setlocal nofoldenable
endif

" Move up a directory using "-"
nmap <buffer> <expr> - g:NERDTreeMapUpdir
