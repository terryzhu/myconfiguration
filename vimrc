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
nmap <C-K> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
set tabstop=2
set shiftwidth=2
:colorscheme ron
set cindent

filetype plugin on

set completeopt=menu

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/tags
set tags+=~/.vim/tags/linux_include

"set the auto complete menu color
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel  cterm=bold ctermfg=9 ctermbg=4

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::

let g:acp_enableAtStartup = 0 "disable it
let g:acp_behaviorKeywordCommand="\<C-x>\<C-o>"

let Tlist_Show_One_File=1
let Tlist_Auto_Open=1
let Tlist_Show_Menu=1
let Tlist_WinWidth=18
let Tlist_WinHeight=10
let Tlist_Close_On_Select=0
let Tlist_Sort_Type='name'
let Tlist_Use_Right_Window = 1

let g:winManagerWindowLayout='FileExplorer'
let g:persistentBehaviour=0 "leave vim if only one window
let g:winManagerWidth=20

":WMToggle to open the winmanager

"add the syntax color rule
"highlight Functions
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
"hi cFunctions gui=NONE cterm=bold  ctermfg=red
""highlight the UPCASE
"syn match cUpcase "\<[A-Z_]*\>\s*"
"hi cUpcase  gui=NONE cterm=bold  ctermfg=blue
