" File: project.vim
" Author: Jeffy Du <jeffy.du@163.com>
" Version: 0.1
"	Version: 0.2 zzhhuujjiiee@qq.com
" Description:
" ------------
" This plugin provides a solution for creating project tags and cscope files.
" If you want to run this plugin in Win32 system, you need add the system-callings
" (ctags,cscope,find,grep,sort) to your system path. Usually, you can find these
" system-callings in Cygwin.
"
" Installation:
" -------------
" 1. Copy project.vim to one of the following directories:
"
"       $HOME/.vim/plugin    - Unix like systems
"       $VIM/vimfiles/plugin - MS-Windows
"
" 2. Start Vim on your project root path.
" 3. Use command ":ProjectCreate" to create project.
" 3. Use command ":ProjectLoad" to load project.
" 4. Use command ":ProjectUpdate" to update project.
" 5: Use command ":ProjectQuit" to quit project.

if exists('loaded_project')
    finish
endif
let loaded_project=1

if v:version < 700
    finish
endif

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" Global variables
if !exists('g:tags_dir')
    let g:tags_dir = ""
endif

if !exists('HL_Enable')
	let HL_Enable=0
endif


if !exists('HL_STLEnable')
	let HL_STLEnable=0
endif

if !exists('HL_SysEnable')
	let HL_SysEnable=0
endif



" flag for tags type
" "d" - macro define
" "e" - enum item
" "f" - function
let s:HLUDFlag = ['d', 'e', 'f', 'g', 'p', 's', 't', 'u','c']
let g:HLUDType = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',' ']

function! s:find_tag_dir()
		" find the project root tags file
		let tags_data = findfile("tags", ".;")
		if tags_data == ''
			return
		endif
		let pos = len(tags_data)
		let dir_name = strpart(tags_data,0,pos - 4)
		let g:tags_dir = dir_name
endfunction



" HLUDLoad                      
" load user types
function! s:HLUDLoad(udtagfile)
	if filereadable(a:udtagfile)
		let s:HLTypeTmp = readfile(a:udtagfile)
		let idx = 0
		while idx < len(s:HLUDFlag)
			let g:HLUDType[idx] = g:HLUDType[idx] . s:HLTypeTmp[idx]
			let idx = idx + 1
		endwhile
	endif
endfunction

" HLUDGetTags                   
" get tag data by tag flag
function! s:HLUDGetTags(flag)
	let idx = index(s:HLUDFlag, a:flag)
	if idx != -1
		return g:HLUDType[idx]
	else
		return ' '
	endif
endfunction

" HLUDColor                     
" highlight tags data
function! s:HLUDColor()
		exec 'syn keyword cUserDefines X_X_X ' . s:HLUDGetTags('d') . s:HLUDGetTags('e')
		exec 'syn keyword cUserFunctions X_X_X ' . s:HLUDGetTags('f') . s:HLUDGetTags('p')
		exec 'syn keyword cUserTypes X_X_X ' . s:HLUDGetTags('t') . s:HLUDGetTags('u') .  s:HLUDGetTags('s') . s:HLUDGetTags('g') . s:HLUDGetTags('c') 
    exec 'hi cUserTypes cterm=bold ctermfg=brown guifg=brown'
    exec 'hi cUserDefines ctermfg=magenta guifg=magenta'
    exec 'hi cUserFunctions ctermfg=red guifg=red'
		echon "    Highlight Syntax Color Successful"
endfunction

" HLUDSync                      
" sync tag data
function! s:HLUDSync(tagsfile, udtagfile)
	" if tag file is not exist, do nothing.
	if !filereadable(a:tagsfile)
		return
	endif

	" parse tag file line by line.
    let g:HLUDType = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',' ']
	for line in readfile(a:tagsfile)
		" parse tag flag
		let idx = stridx(line, ';"' . "\t")
		if idx != -1
			let s:flag = strpart(line, idx+3, 1)

			" parse and save flag
			let idx = index(s:HLUDFlag, s:flag)
			if idx != -1
				let g:HLUDType[idx] = g:HLUDType[idx] . matchstr(line, '^\<\h\w*\>') . ' '
			endif
		endif
	endfor

	" write tags data to file.
	call writefile(g:HLUDType, a:udtagfile)
endfunction

" WarnMsg                       
" display a warning message
function! s:WarnMsg(msg)
    echohl WarningMsg
    echon a:msg
    echohl None
endfunction

" ProjectCreate                 
" create project data
function! s:ProjectCreate()
    " create tags file
    if executable('ctags')
        call system('ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -o  tags ' . getcwd())
    else
        call s:WarnMsg("command 'ctags' not exist.")
        return -1
    endif

    call s:HLUDSync('tags',  'udtags')
    echon "create project done"
    return 1
endfunction

" ProjectUpdate                 
" update project data
function! s:ProjectUpdate()
	  call s:find_tag_dir()
		let dir_name = g:tags_dir
    exe 'cd ' . dir_name 

    " create tags file
    if executable('ctags')
        call system('ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -o ' . tags_data  . getcwd())
    else
        call s:WarnMsg("command 'ctags' not exist.")
        return -1
    endif

    call s:HLUDSync('tags', 'udtags')
    call s:HLUDColor()
    echo "update project done."
    return 1
endfunction

" ProjectLoad                   
" load project data
function! s:ProjectLoad()
		if g:HL_Enable == 0
			return 1
		endif
		if g:HL_SysEnable == 1
			call s:LoadSysHL()
		endif
		if g:HL_STLEnable == 1
			call s:LoadSTLHL()
		endif
		call s:find_tag_dir()
	 let dir_name = g:tags_dir
		" color user defined.
    call s:HLUDLoad(dir_name . 'udtags')
		echon "    Load Project done."
    return 1
endfunction

" ProjectQuit                   
" quit project
function! s:ProjectQuit()
endfunction

function! s:LoadSTLHL()
  " Initial the stl types
 	 let g:stl_udtags=expand("$HOME/.vim/tags/stludtags")
 	 let g:stl_tags=expand("$HOME/.vim/tags/stltags")
	 if !filereadable(g:stl_udtags)
  	call s:HLUDSync(g:stl_tags,g:stl_udtags)
  endif
 	 call s:HLUDLoad(g:stl_udtags)
endfunction

function! s:LoadSysHL()
  " Initialize the sys call types
  let g:syscall_udtags=expand("$HOME/.vim/tags/syscall_udtags")
  let g:syscall_tags=expand("$HOME/.vim/tags/syscall_tags")
  if !filereadable(g:syscall_udtags)
  	echo "It will take 1 minutes to initialize the sys call types"
  	call s:HLUDSync(g:syscall_tags,g:syscall_udtags)
  endif
  call s:HLUDLoad(g:syscall_udtags)
endfunction

command! -nargs=0 -complete=file ProjectCreate call s:ProjectCreate()
command! -nargs=0 -complete=file ProjectUpdate call s:ProjectUpdate()
command! -nargs=0 -complete=file ProjectLoad call s:ProjectLoad()
command! -nargs=0 -complete=file ProjectQuit call s:ProjectQuit()
command! -nargs=0 -complete=file HighlightCode call s:HLUDColor()

aug Project
    au VimEnter,FileType c,cpp,h  call s:ProjectLoad()
    au VimLeavePre * call s:ProjectQuit()
    au BufEnter,FileType c,cpp,h call s:HLUDColor()
aug END

nnoremap <leader>jc :ProjectCreate<cr>
nnoremap <leader>ju :ProjectUpdate<cr>
nnoremap <leader>jl :ProjectLoad<cr>
nnoremap <leader>jh :HighlightCode<cr>
nnoremap <leader>jq :ProjectQuit<cr>

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set foldenable foldmethod=marker:



