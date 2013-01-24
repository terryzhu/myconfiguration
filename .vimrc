set nocompatible
set nu
set noswapfile
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
set tags+=~/.vim/tags/stltags
set tags+=~/.vim/tags/syscall_tags

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
let OmniCpp_ShowScopeInAbbr = 1

let g:acp_enableAtStartup = 0 "disable it
let g:acp_behaviorKeywordCommand="\<C-x>\<C-o>"


nnoremap <silent> <F11> :TlistToggle<CR>
let Tlist_Show_One_File=1
let Tlist_Auto_Open=0
let Tlist_Show_Menu=1
let Tlist_WinWidth=18
let Tlist_WinHeight=10
let Tlist_Close_On_Select=0
let Tlist_Sort_Type='name'
let Tlist_Use_Right_Window = 1

let g:winManagerWindowLayout = "FileExplorer"
let g:persistentBehaviour=1 
"leave vim if only one window
let g:winManagerWidth=20
":WMToggle to open the winmanager
map <F12> :WMToggle<CR>

let mapleader = ","


" remember the old edit position
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif


let g:HL_Enable=1
