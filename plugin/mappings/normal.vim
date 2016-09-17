" Normal mode mappings.

" Toggle fold at current position with shift-tab
nnoremap <s-tab> za

" Avoid switching to Ex mode
nmap Q q

" Turn off K
nnoremap K <nop>

" Press minus to open NERDTree
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

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

" Use cursor keys to move around the quickfix list
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" Strip trailing whitespace
nmap _$ :call functions#preserve("%s/\\s\\+$//e")<CR>

" Reindent entire file
nmap _= :call functions#preserve("normal gg=G")<CR>

