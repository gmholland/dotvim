syn match texStatement "\\[Gg]ls\%(pl\)\=\>" nextgroup=texGls
syn match texStatement "\\gls\%(add\|desc\|link\|unset\|reset\|symbol\)\>" nextgroup=texGls
syn match texStatement "\\acr\%(long\|full\|short\)\>" nextgroup=texGls

syn region texGls matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell
