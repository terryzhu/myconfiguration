set nocompatible
set nu
nmap <C-B> <LEFT>
nmap <C-F> <RIGHT>
nmap <C-P> <UP>
nmap <C-N> <DOWN>
nmap <C-A> <HOME>
nmap <C-E> <END>
imap <C-B> <LEFT>
imap <C-F> <RIGHT>
imap <C-P> <UP>
imap <C-N> <DOWN>
imap <C-A> <HOME>
imap <C-E> <END>
set tabstop=2
set shiftwidth=2
:colorscheme ron
set cindent

"add the syntax color rule
"highlight Functions
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
"hi cFunctions gui=NONE cterm=bold  ctermfg=red
""highlight the UPCASE
"syn match cUpcase "\<[A-Z_]*\>\s*"
"hi cUpcase  gui=NONE cterm=bold  ctermfg=blue
