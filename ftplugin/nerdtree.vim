setlocal colorcolumn=

if has('folding')
	setlocal nofoldenable
endif

" Move up a directory using "-"
nmap <buffer> <expr> - g:NERDTreeMapUpdir
