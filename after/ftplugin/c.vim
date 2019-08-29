" Folding
setlocal foldmethod=syntax
setlocal foldlevel=0
setlocal foldcolumn=1

" <Leader>i -- Run clang-format (mnemonic: indentation)
noremap <Leader>i :py3f ~/.vim/tools/clang-format.py<CR>

" vim:set ft=vim et sw=2:
