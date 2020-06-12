if has('multi_byte')
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

scriptencoding utf-8

" TODO
" - statusline colours
" - focus
"   - don't colorcolumn diff windows
" - Fix path in statusline: currently the path isn't always shown relative to
"   the current directory
" - Use a better status line for 'special' windows (taglist, quickfix etc.)
" - Fix modelines

if filereadable(expand("~/local/.vimrc"))
  source ~/local/.vimrc
endif

" Plugin Loading - {{{
if &loadplugins
  if has('packages')
    " Linux only plugins
    if has('unix')
      packadd! command-t
      packadd! syntastic
      packadd! vim-slime
      packadd! YouCompleteMe
    endif
    packadd! cmake-syntax
    packadd! cscopemaps.vim
    packadd! detectindent
    packadd! FastFold
    packadd! goyo.vim
    packadd! linediff.vim
    packadd! loupe
    packadd! nerdtree
    packadd! python-mode
    packadd! tagbar
    packadd! tcomment_vim
    packadd! ultisnips
    packadd! vim-cmake-completion
    packadd! vim-colors-solarized
    packadd! vim-easydir
    packadd! vim-edk-mhs
    packadd! vim-eunuch
    packadd! vim-fugitive
    packadd! vim-markdown
    packadd! vim-markdown-folding
    packadd! vim-opencl
    packadd! vim-repeat
    packadd! vim-speeddating
    packadd! vim-surround
    packadd! vim-unimpaired
    packadd! vimtex
    packadd! YCM-Generator
  else
    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('pack/bundle/opt/{}')
  endif
endif
" - }}}

" - Indentation and Formatting - {{{
" Use filetype plugins and indentation
if has('autocmd')
  filetype plugin indent on
endif

set autoindent        " Maintain indentation of current line for next lines
set formatoptions+=n  " Recognize numbered lists when formatting text
set formatoptions+=j  " Delete comment character when joining commented lines
set textwidth=80      " Hard wrap at 80 columns
set nojoinspaces      " Don't automatically add a space after a '.' when joining lines

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

" - Display - {{{
set belloff=all     " Disable the bell and window flashing
set winminheight=0  " Set minimum height of window to 0
set scrolloff=3     " Keep at least 3 lines above and below the cursor
set sidescrolloff=5 " Keep at least 5 columns to the right and left of the cursor
set hidden          " Allow buffers to be in the background
set lazyredraw      " Don't update screen during macro playback
set number          " Turn on line numbers

" Show relative line numbers if possible
if exists('+relativenumber')
  set relativenumber
endif

" Make folded text more legible
set fillchars="vert:|,fold:\"

set list                    " Show whitespace characters
set listchars=tab:›\        " SINGLE RIGHT-POINTING ANGLE QUOTATION MARK (U+203A, UTF-8: E2 80 BA) + SPACE
set listchars+=extends:»    " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«   " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•      " BULLET (U+2022, UTF-8: E2 80 A2)

if has('linebreak')
  set linebreak             " Wrap long lines at characters in 'breakat' setting
  if has('win32')
    " Source Code Pro on Windows doesn't have all the unicode arrows
    let &showbreak='↘ '     " Line continuation character - SOUTH EAST ARROW (U+2198, UTF-8: E2 86 98)
  else
    let &showbreak='↳ '     " Line continuation character - DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
  endif
endif
" - }}}

" - Input - {{{
set backspace=indent,start,eol  " Allow unrestricted backspacing in insert mode
set mouse=a                     " Use the mouse in all modes
" - }}}

" - Highlighting and Colours - {{{
" Use syntax highlighting
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Highlight up to 255 columns beyond 'textwidth'
if exists('+colorcolumn')
  let &colorcolumn='+' . join(range(1, 254), ',+')
endif

set t_Co=16             " 16 colour vim
colorscheme solarized   " Use solarized scheme, relies on vim-solarized plugin

" Use light background in GUI mode, dark in terminal mode
if has("gui_running")
  set background=light
else
  set background=dark
endif

set cursorline                  " Highlight the current line
set highlight+=@:ColorColumn    " Blend ~/@ at end of window, 'showbreak' character
set highlight+=N:DiffText       " Make current line number stand out a bit

" -- Make current window more obvious -- {{{
" Inactive windows have dull background and simpler statusline
if has('autocmd')
  function! s:FocusAutocmds()
    augroup FocusAutocmds
      autocmd!

      " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
      autocmd VimEnter * autocmd WinEnter * let w:created=1
      autocmd VimEnter * let w:created=1

      " Turn off highlighting of current line for inactive windows
      autocmd InsertLeave,VimEnter,WinEnter * if autocmds#should_cursorline() | setlocal cursorline | endif
      autocmd InsertEnter,WinLeave * if autocmds#should_cursorline() | setlocal nocursorline | endif

      " Simple statusline for inactive windows
      if has('statusline')
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_statusline()
        autocmd FocusLost,WinLeave * call autocmds#blur_statusline()
      endif

    augroup END
  endfunction

  call s:FocusAutocmds()
endif
" -- }}}

" - }}}

" - Status - {{{
set laststatus=2  " Always enable the statusline
set ruler         " Display current line and column number in lower right
set showcmd       " Display operators as they are being typed

" -- Statusline -- {{{
" the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
if has('statusline')
  set statusline=
  set statusline+=%{statusline#branch()}      " Git branch
  set statusline+=>                           " FIXME Powerline arrow
  set statusline+=\                           " Space
  set statusline+=%<                          " Truncation point, if not enough width available
  set statusline+=%{statusline#fileprefix()}  " Relative path to file's directory
  set statusline+=%t                          " Filename
  set statusline+=\                           " Space
  set statusline+=%h                          " [help] if buffer is a help file
  set statusline+=%m                          " [+] if modified, [-] if not modifiable
  set statusline+=%r                          " [RO] if buffer readonly

  set statusline+=%=                          " Left right split

  set statusline+=%{statusline#fenc()}        " File encoding if not UTF-8
  set statusline+=%{statusline#fileformat()}  " File format if not unix
  set statusline+=%y                          " [filetype]
  set statusline+=\                           " Space
  set statusline+=<                           " FIXME Powerline arrow
  set statusline+=\                           " Space
  set statusline+=%-14.(%l\ :\ %c%)\          " Line number : Column number
  set statusline+=%3.p%%\                     " Percentage through file
endif
" -- }}}
" - }}}

" - Completion - {{{
set wildmenu " Use enhanced command-line completion
" - }}}

" - Searching - {{{
set hlsearch      " Turn on highlighting for searches
set incsearch     " Use incremental search
set ignorecase    " Don't worry about case in searches
set smartcase     " Use case sensitive search if search contains uppercases
set history=1000  " Keep a longer history for commands and search patterns

" Enable extended % matching to match if/elsif/else/end etc. for appropriate
" languages
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" - }}}

" - Temporary files - {{{
" Backup files
if exists('$SUDO_USER')
  set nobackup                    " Don't create root owned files
  set nowritebackup
else
  set backupdir=~/.vim/tmp/backup " Keep backup files out of the way
  set backupdir+=.
endif

" Swap files
if exists('$SUDO_USER')
  set noswapfile                  " Don't create root owned files
else
  set directory=~/.vim/tmp/swap// " Keep swap files out of the way
  set directory+=.
endif

" Undo files
if has('persistentundo')
  if exists('$SUDO_USER')
    set noundofile               " Don't create root owned files
  else
    set undodir=~/.vim/tmp/undo  " Keep undo files out of the way
    set undodir+=.
    set undofile                 " Actualy use undo files
  endif
endif

" Session files
if has('mksession')
  set viewdir=~/.vim/tmp/view   " Override ~/.vim/view default
  set viewoptions=cursor,folds  " Save/restore just these (with `:{mk,load}view`)
endif
" - }}}

" - Mappings - {{{
" -- Leader mappings -- {{{
" Map leader to comma
let mapleader=","

" Map <LocalLeader> to backslash
let localleader="\\"

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" <Leader>cd -- Change working directory to the directory of the file being
" edited. (mnemonic: change directory)
nnoremap <Leader>cd :cd %:p:h<CR>

" <Leader>d -- Open the NERDTree directory browser (mnemonic: directory)
nnoremap <Leader>d :NERDTreeToggle<CR>

" <Leader>l -- Toggle the taglist (mnemonic: label)
nnoremap <Leader>l :TagbarToggle<CR>

" <Leader>M -- Maximize the split window (mnemonic: maximize)
nnoremap <Leader>M :resize 1000<CR>

" <Leader>n -- Cycle through relativenumber + number, number only, and no
" numbering (mnemonic: numbers)
nnoremap <silent> <Leader>n :call mappings#cycle_numbering()<CR>
" -- }}}

" -- Normal mode mappings -- {{{
" <Shift>-<Tab> -- Toggle fold at current position
nnoremap <s-tab> za

" Avoid switching to Ex mode
nmap Q q

" Turn off K. This usually searches man pages for the word under the cursor,
" which might be useful but is often pressed accidentally.
noremap K <nop>

" Press minus to open NERDTree
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Resize split windows more easily, "+" to make bigger, "_" to make smaller
nnoremap + :resize +5<CR>
nnoremap _ :resize -5<CR>

" Easier split navigation
" Use ctrl-[hjkl] to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Strip trailing whitespace from the file
nmap _$ :call functions#preserve("%s/\\s\\+$//e")<CR>

" Reindent entire file
nmap _= :call functions#preserve("normal gg=G")<CR>
" -- }}}
" - }}}

" - Commands - {{{
" -- :CloseHiddenBuffers - Close all hidden buffers -- {{{
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction
" -- }}}

" -- :DiffOrig - Diff changes to file since opened -- {{{
command! DiffOrig call s:difforig()
function! s:difforig()
  vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endfunction
" -- }}}

" -- :Scratch <command> - Execute command in scratch area -- {{{
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)
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
" -- }}}

" -- :Scriptnames - A wrapper for :scriptnames that places output in scratch area -- {{{
command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
" -- }}}

" -- :SetStyle - Set coding style -- {{{
"
" Currently supported styles:
" - linux
" - gnu
command! -nargs=? SetStyle call s:SetStyle(<f-args>)
function! s:SetStyle(...)
  if a:0 > 0
    let l:style = a:1
  else
    let l:style = input('set coding style (options: linux, gnu) = ')
  endif

  " Linux coding style
  if l:style ==? 'linux'
    set ts=8 sw=8 sts=8 noet
    if has('cindent')
      set cindent
      set cinoptions=:0,l1,t0,g0,(0
    endif
    let g:c_syntax_for_h = 1
    if $LINUX_SRCDIR != ""
      if has('cscope') && !exists("g:setstyle_linux_cscope_loaded")
        cscope add $LINUX_SRCDIR $LINUX_SRCDIR
        let g:setstyle_linux_cscope_loaded = 1
      endif
      set path+=$LINUX_SRCDIR/include
    else
      echohl WarningMsg
      echo "LINUX_SRCDIR environment variable not set, not adding cscope connection"
      echohl None
    endif
    let g:setstyle_style = "linux"

  " GNU coding style
  elseif l:style ==? 'gnu'
    set ts=8 sw=2 sts=2 et
    if has('cindent')
      set cindent
      set cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    endif
    set formatoptions-=ro formatoptions+=cql

  else
    echohl ErrorMsg
    echo l:style . " is not a valid style"
    echohl None
  endif
endfunction
" -- }}}

" -- :Stab - Set tabstop, softtabstop and shiftwidth to the same value -- {{{
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
" -- }}}

" -- :Wrap - A wrapper for :set wrap -- {{{
command! -nargs=* Wrap set wrap linebreak nolist
" -- }}}
" - }}}

" - Plugin Settings - {{{
" -- NERDTree -- {{{
" Would be useful mappings, but they interfere with my default window movement
" bindings (<C-j> and <C-k>).
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'

" Show hidden files by default
let g:NERDTreeShowHidden=1
" -- }}}

" -- tcomment -- {{{
" Prevent tcomment from making a zillion mappings (we just want the operator).
let g:tcommentMapLeader1=''
let g:tcommentMapLeader2=''
let g:tcommentMapLeaderCommentAnyway=''
let g:tcommentTextObjectInlineComment=''

" The default (g<) is a bit awkward to type.
let g:tcommentMapLeaderUncommentAnyway='gu'
" -- }}}

" -- YouCompleteMe -- {{{
" Complete inside of comments
let g:ycm_complete_in_comments = 1

" Read identifiers from tags file
"let g:ycm_collect_identifiers_from_tags_files = 1

" Seed identifiers with syntax
"let g:ycm_seed_identifiers_with_syntax = 1

" YouCompleteMe filetype blacklist, same as default but with "markdown" and
" "text" removed
let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'unite' : 1,
      \ 'tagbar' : 1,
      \ 'pandoc' : 1,
      \ 'qf' : 1,
      \ 'vimwiki' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}

" Set autocompletion triggers for tex files
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]

" Set ycm_global_ycm_extra_conf according to filetype
autocmd FileType c let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf_c.py"
autocmd FileType cpp let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf_cpp.py"

" Don't ask about loading our own ycm_extra_conf.py files
let g:ycm_extra_conf_globlist = [
      \ '~/.vim/*',
      \ '!~/.vim/bundle/*',
      \ '~/RCL/cfuse/*'
      \ ]

" Use the first python executable found in PATH for completions
" FIXME the following variable no longer exists
"let g:ycm_python_binary_path = 'python3'
" -- }}}

" -- UltiSnips -- {{{
" Create new snippets in ~/.vim/UltiSnips
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/UltiSnips'

" Only load snippets from ~/.vim/UltiSnips
let g:UltiSnipsSnippetsDirectories = [$HOME . '/.vim/UltiSnips']

" Don't search for directories named "snippets"
let g:UltiSnipsEnableSnipMate = 0

" Trigger configuration
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Split window during :UltiSnipsEdit
let g:UltiSnipsEditSplit = "horizontal"
" -- }}}

" -- vimtex -- {{{
" Detect *.tex files as latex
let g:tex_flavor='latex'

" Use zathura as the pdf viewer
let g:vimtex_view_method = 'zathura'

" Enable folding
let g:vimtex_fold_enabled = 1
" -- }}}

" -- vim-markdown-folding -- {{{
" Use nested folding in markdown files by default. Switch to stacked folding
" with :FoldToggle
let g:markdown_fold_style = 'nested'
" -- }}}

" -- python-mode -- {{{
" Disable refactoring with Rope since it conflicts with YouCompleteMe
let g:pymode_rope = 0

" Disable colorcolumn display since we already define one
let g:pymode_options_colorcolumn = 0

" Use python3 by default
let g:pymode_python = 'python3'

" Disable :PymodeRun
let g:pymode_run = 0

" Disable code checking on every save
let g:pymode_lint_on_write = 0
" -- }}}

" -- syntastic -- {{{
" Don't run checkers after :wq
let g:syntastic_check_on_wq = 0

" Don't populate the location-list since it may conflict with other plugins
" Must fill it explicitly with :Errors
let g:syntastic_always_populate_loc_list = 0

" Don't open and close the location-list automatically
let g:syntastic_auto_loc_list = 0

" Don't automatically run checkers, use :SyntasticCheck to run checks
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }

" Let clang_tidy check use JSON compilation database
let g:syntastic_cpp_clang_tidy_post_args = ""
" -- }}}

" -- FastFold -- {{{
" FastFold is incompatible with how vim-markdown-folding works so disable
" for markdown files
let g:fastfold_skip_filetypes = ['markdown', 'taglist']
" -- }}}

" -- vim-slime -- {{{
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1
" -- }}}

" -- goyo.vim -- {{{
let s:settings = {}

" Define additional changes when entering goyo mode
function! s:goyo_enter()
  " Disable focus autocmds
  augroup FocusAutocmds
    autocmd!
  augroup END
  augroup! FocusAutocmds

  let s:settings = {
        \ 'spell' : &spell,
        \ 'showmode' : &showmode,
        \ 'showcmd' : &showcmd,
        \ 'cursorline' : &cursorline,
        \ 'foldmethod' : &foldmethod,
        \ 'foldlevel' : &foldlevel
        \ }

  set nospell            " Dont' spell check
  set noshowmode         " Don't show the current mode
  set noshowcmd          " Don't show commands as they are typed
  set nocursorline       " Don't highlight the current line
  set foldmethod=manual  " Disable automatic folding
  set foldlevel=99       " Open folds
  syntax off             " Disable syntax highlighting
  let b:ycm_largefile=1  " Disable YouCompleteMe for the buffer

  if executable('tmux') && strlen($TMUX)
    " Turn off tmux status bar
    silent !tmux set status off
    " Maximize current tmux pane
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
endfunction

" Undo changes from goyo_enter
function! s:goyo_leave()

  " Restore settings
  for [k, v] in items(s:settings)
    execute 'let &' . k . '=' . string(v)
  endfor
  let b:ycm_largefile=0
  syntax on

  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif

  call s:FocusAutocmds()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" -- }}}
" - }}}

" vim:set ft=vim et ts=2 sw=2 sts=2:
