set backspace=indent,start,eol 	" allow unrestricted backspacing in insert mode

set mouse=a 					" use the mouse in all modes

set wildmenu 					" better command completion

set hidden 						" current buffer can be but into the background

set scrolloff=3					" maintain more text around the cursor when scrolling

set wmh=0 						" small minimum window height to aid splitting lots of files

set textwidth=80 				" automatically hard wrap at 80 columns

let g:tex_flavor='latex'		" detect *.tex files as latex

" - Whitespace and indentation - {{{
set autoindent 					" maintain indent of current line
filetype plugin indent on 		" use smart indentation

set formatoptions+=n 			" smart auto-indenting inside numbered lists

" These are the common options for indenting:
" 1. Indentation without hard tabs (spaces only):
" - set 'expandtab', set 'shiftwidth' and 'softtabstop' to the same value,
"   leave 'tabstop' at default value
"set expandtab
"set shiftwidth=4
"set softtabstop=4

" 2. Indentation purely with hard tabs
" - set 'tabstop' and 'shiftwidth' to the same value, leave 'expandtab' at
"   default value ('noexpandtab') and leave 'softtabstop' unset
set shiftwidth=4
set tabstop=4

" 3. Indentation with mixed tabs and spaces
" - set 'shiftwidth' and 'softtabstop' to the same value, leave 'expandtab'
"   at its default value ('noexpandtab'), leave 'tabstop' at its default value
"set shiftwidth=4
"set softtabstop=4
" - }}}

" - Status - {{{
set laststatus=2 	" always enable the statusline
set number 			" turn on line numbers
set ruler 			" display current line and column number in lower right
set showcmd 		" display operators as they are being typed
" - }}}

" - Highlighting, search and colours - {{{
syntax on			" use syntax higlighting
set hlsearch 		" turn on higlighting for searches
set incsearch 		" use incremental search
set ignorecase 		" don't worry about case in searches
set smartcase 		" if we have an uppercase in the search then case is meaningful
set history=1000 	" keep a longer history for commands and search patterns

" Highlight up to 255 columns beyond 'textwidth'
if exists('+colorcolumn')
	let &colorcolumn='+' . join(range(1, 254), ',+')
endif

set t_Co=16 				" 16 colour vim
colorscheme solarized		" use solarized scheme

if has("gui_running")
	set background=light 	" use light background in gui mode
else
	set background=dark 	" use dark background in gui mode
endif

" - }}}

" - Backup and swap files - {{{
if exists('$SUDO_USER')
	set nobackup 				" don't create root owned files
	set nowritebackup			" don't create root owned files
else
	set backupdir=~/local/.vim/tmp/backup
	set backupdir+=.
endif

if exists('$SUDO_USER')
	set noswapfile 				" don't create root owned files
else
	set directory=~/local/.vim/tmp/swap// " keep swap files out of the way
	set directory+=.
endif
" - }}}

" - Sessions - {{{
if has('mksession')
	if isdirectory('~/local/.vim/tmp')
		set viewdir=~/local/.vim/tmp/view
	else
		set viewdir=~/.vim/tmp/view 		" override ~/.vim/view default
	endif
	set viewoptions=cursor,folds 			" save/restore just these (with `:{mk,load}view`)
endif
" - }}}
