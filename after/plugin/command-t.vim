" - Settings -- {{{

" Use <ESC> to exit out of command-t split
let g:CommandTCancelMap=['<ESC>', '<C-c>']

let g:CommandTMaxCachedDirectories=10
let g:CommandTMaxFiles=1000000
let g:CommandTScanDotDirectories=1
let g:CommandTFileScanner='git'
let g:CommandTTraverseSCM='pwd'
let g:CommandTWildIgnore=&wildignore
let g:CommandTWildIgnore.=',*/.git'
let g:CommandTWildIgnore.=',*/.hg'
" - }}}

" vim:set ft=vim et sw=2:
