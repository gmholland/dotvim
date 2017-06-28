" Switch to plaintext mode with: call functions#plaintext()
function! functions#plaintext() abort
  setlocal nolist
  setlocal spell
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0
  setlocal linebreak

  nnoremap <buffer> j gj
  nnoremap <buffer> k gk

  " Ideally would keep 'list' set, and restrict 'listchars' to just show
  " whitespace errors, but 'listchars' is global and I don't want to go through
  " the hassle of saving and restoring.
  if has('autocmd')
    autocmd BufWinEnter <buffer> match Error /\s\+$/
    autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
    autocmd InsertLeave <buffer> match Error /\s\+$/
    autocmd BufWinLeave <buffer> call clearmatches()
  endif
endfunction

" Preserve the last search and cursor position when running a command
function! functions#preserve(command)
  " Preparation: save last search, and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Preview markdown in browser
function! functions#markdown_preview() abort
  let curr_file = expand('%:t')
  let curr_file_path = expand('%:p')
  let html_file = curr_file . '.html'
  let html_file_path = '/tmp/' . html_file

  " Generate html from markdown
  call system('grip "' . curr_file_path . '" --export ' . html_file_path . ' --title ' . html_file)

  " Open in browser if necessary
  let browser_wid = system('xdotool search --name ' . html_file)
  if !browser_wid
    call system('xdg-open ' . html_file_path)
  endif
endfunction

" vim:set ft=vim et sw=2:
