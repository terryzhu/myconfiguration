set backspace=2
syntax on
set nocompatible
set number
set showcmd
" set ignorecase
set hlsearch
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:>-

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
set ignorecase
filetype plugin on

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

hi cursorline term=underline cterm=underline
set cursorline


" save session
let g:AutoSessionFile=expand('~/.vim/session.vim')
if filereadable(g:AutoSessionFile)
    if argc() == 0
        au VimEnter * call EnterHandler()
    endif
endif
au VimLeave * call LeaveHandler()
function! LeaveHandler()
	exec ':NERDTreeClose'
	exec ':TlistClose'
	let f = expand("%:p")
	if f =~ "cc"  || f =~ "hh" 
		" save when c++ code
		exec "mks! ".g:AutoSessionFile
	endif
endfunction
function! EnterHandler()
    exe "source ".g:AutoSessionFile
endfunction


let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 10
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|dll|a|o|so|lo|la|pyc|d)$' }
let g:ctrlp_map ='F7'


" command:
" ctags  -I __THROW  -I __THROWNL -I __attribute_pure__ -I __nonnull -I __attribute__ -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C++  -o $HOME/.vim/tags1  
set tags+=~/.vim/tags1
set tags+=~/.vim/tags2
set tags+=~/.vim/crontags
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_ShowScopeInAbbr = 1
let OmniCpp_SelectFirstItem = 2
"set the auto complete menu color
"highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel cterm=bold ctermfg=9 ctermbg=4


let g:acp_enableAtStartup = 0 "disable it
let g:acp_behaviorKeywordCommand="\<C-x>\<C-o>"
let g:acp_ignorecaseOption = 0
"set the popup menu height
set pumheight=10
set completeopt=menu,longest

" set ctrl d/u line number
set scroll=3

" F6
noremap <unique> <silent> <F6> :CtrlP<CR>
" F7
nmap <F7> :bprevious<CR>:bdelete #<CR>
" F8
noremap <unique> <silent> <F8> :CtrlPBuffer<CR>
" F10
nmap <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
" F11
map <F11> :NERDTreeToggle<CR>
" F12
nnoremap <silent> <F12> :TlistToggle<CR>
