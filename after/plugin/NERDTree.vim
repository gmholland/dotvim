" Disable display of ? and Bookmarks label
let g:NERDTreeMinimalUI=1

" Allow NERDTree to keep track of the previous file
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" Single-click to toggle directory nodes, double click to open non-directory
" nodes
let g:NERDTreeMouseMode=2

" When opening the NERDTree select the file we are coming from
if has('autocmd')
	augroup WincentNERDTree
		autocmd!
		autocmd User NERDTreeInit call autocmds#attempt_select_last_file()
	augroup END
endif
