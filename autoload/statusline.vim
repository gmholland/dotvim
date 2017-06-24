scriptencoding utf-8

function! statusline#branch() abort
  if exists('*fugitive#head')
    let l:branchname = fugitive#head(7)
    if strlen(l:branchname) > 0
      return '   '.l:branchname.' '
    endif
  endif
  return ""
endfunction

function! statusline#fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename ==# '' || l:basename ==# '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return &fenc . ' '
  else
    return ''
  endif
endfunction

" vim:set ft=vim et ts=2 sw=2 sts=2:
