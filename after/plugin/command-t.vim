" - Settings -- {{{

" Use <ESC> to exit out of command-t split
if &term =~# 'xterm'
	let g:CommandTCancelMap=['<ESC>', '<C-c>']
endif

let g:CommandTMaxCachedDirectories=10
let g:CommandTMaxFiles=1000000
let g:CommandTScanDotDirectories=1
let g:CommandTTraverseSCM='pwd'
let g:CommandTWildIgnore=&wildignore
let g:CommandTWildIgnore.=',*/.git'
let g:CommandTWildIgnore.=',*/.hg'
" - }}}

" - Mappings - {{{
nmap <unique> <Leader>c <Plug>(CommandTCommand)
nmap <unique> <Leader>h <Plug>(CommandTHelp)
nmap <unique> <LocalLeader>h <Plug>(CommandTHistory)
nmap <unique> <LocalLeader>l <Plug>(CommandTLine)
nmap <unique> <LocalLeader>s <Plug>(CommandTSearch)
nmap <unique> <LocalLeader>t <Plug>(CommandTTag)
" - }}}
