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

function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return '[' . &fenc . ']'
  else
    return ''
  endif
endfunction

function! statusline#fileformat() abort
  if strlen(&fileformat) && &fileformat !=# 'unix'
    return '[' . &fileformat . ']'
  else
    return ''
  endif
endfunction

function! statusline#position() abort
  let l:pos= ' '
  let l:column = virtcol('.')
  let l:width = virtcol('$')
  let l:line = line('.')
  let l:height = line('$')

  " Add padding to stop pos from changing too much as we move the cursor
  let l:padding = strlen(l:height) - strlen(l:line)
  if l:padding
    let l:pos .= repeat(' ', l:padding)
  endif

  let l:pos .= l:line
  let l:pos .= ' : '

  " Add padding to stop pos from changing too much as we move the cursor.
  if strlen(l:column) < 2
    let l:pos .= ' '
  endif

  let l:pos.=l:column
  let l:pos.=' '

  return l:pos
endfunction

" vim:set ft=vim et ts=2 sw=2 sts=2:
