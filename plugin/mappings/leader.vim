" Leader mappings.

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" <Leader>cd -- Change working directory to the directory of the file being
" edited. (mnemonic: change directory)
nnoremap <Leader>cd :cd %:p:h<CR>

" <Leader>i -- Run clang-format (mnemonic: indentation)
map <Leader>i :py3f ~/.vim/tools/clang-format.py<CR>

" <Leader>d -- Open the NERDTree directory browser (mnemonic: directory)
nnoremap <Leader>d :NERDTreeToggle<CR>

" <Leader>l -- Toggle the taglist (mnemonic: label)
nnoremap <Leader>l :TagbarToggle<CR>

" <Leader>M -- Maximize the split window (mnemonic: maximize)
nnoremap <Leader>M :resize 1000<CR>

" <Leader>r -- Cycle through relativenumber + number, number only, and no
" numbering (mnemonic: relative)
nnoremap <silent> <Leader>r :call mappings#cycle_numbering()<CR>
