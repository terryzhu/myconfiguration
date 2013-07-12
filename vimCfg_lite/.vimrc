set backspace=2
syntax on
set nocompatible
set number
set showcmd
" set ignorecase
set hlsearch
set noswapfile
set tabstop=2
"set expandtab

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

noremap <C-J> <C-E>
noremap <C-K> <C-Y>

set cindent
set laststatus=2
set statusline=%2*\ %F%m%r%h%w\ \ [%l/%L]\ [%p%%]
:colorscheme ron
filetype plugin on

nnoremap <silent> <F12> :TlistToggle<CR>
map <F11> :NERDTreeToggle<CR>
let g:winManagerWidth=25
let g:AutoOpenWinManager=0
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Show_One_File=1
let Tlist_Show_Menu=1 

syn match cFuntions display "[a-zA-Z_][a-zA-Z_0-9]\{-1,}\s\{-0,}(\{1}"ms=s,me=e-1                                                   
hi def link cFuntions Special

"autocmd VimEnter * NERDTree                                    
"autocmd TabEnter * NERDTreeMirror                              
"autocmd TabEnter * wincmd p

let NERDTreeWinPos='left'  
let NERDTreeWinSize=20

autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif

set shellredir=>
