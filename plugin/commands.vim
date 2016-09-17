" :difforig - diff changes to file since opened
command! DiffOrig call s:difforig()
function s:difforig()
	vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endfunction

" :Stab - Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call s:Stab()
function! s:Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		" do we want expantab as well?
		let l:expandtab = confirm('set expandtab?', "&Yes\n&No\n&Cancel")
		if l:expandtab == 3
			" abort?
			return
		endif
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
		if l:expandtab == 1
			setlocal expandtab
		else
			setlocal noexpandtab
		endif
	endif
	" show the selected options
	call s:SummarizeTabs()
endfunction

" Print summary of tab settings
function! s:SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

function! s:Scratch (command, ...)
	redir => lines
	let saveMore = &more
	set nomore
	execute a:command
	redir END
	let &more = saveMore
	call feedkeys("\<cr>")
	new | setlocal buftype=nofile bufhidden=hide noswapfile
	put=lines
	if a:0 > 0
		execute 'vglobal/'.a:1.'/delete'
	endif
	if a:command == 'scriptnames'
		%substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
	endif
	silent %substitute/\%^\_s*\n\|\_s*\%$
	let height = line('$') + 3
	execute 'normal! z'.height."\<cr>"
	0
endfunction

command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

command! -nargs=* Wrap set wrap linebreak nolist
