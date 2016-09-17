" Indentation
setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Folding
setlocal foldmethod=manual
setlocal foldcolumn=4

" VHDL settings for Tagbar
let g:tagbar_type_vhdl = {
	\ 'ctagstype': 'vhdl',
	\ 'kinds' : [
		\'d:prototypes',
		\'b:package bodies',
		\'e:entities',
		\'a:architectures',
		\'t:types',
		\'p:processes',
		\'f:functions',
		\'r:procedures',
		\'c:constants',
		\'T:subtypes',
		\'r:records',
		\'C:components',
		\'P:packages',
		\'l:locals'
	\]
\}
