call functions#plaintext()
setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
setlocal textwidth=80

" <Leader>p -- Preview markdown in browser (mnemonic: preview)
nnoremap <silent> <Leader>p :call functions#markdown_preview()<CR>
