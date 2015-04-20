" Basic setting and declarations ---{{{

" leader and local mapleaders
let mapleader = ","
let maplocalleader = "\\"

" show numbers
set number

" No code wrapping
set nowrap

" turn on the filetype recognition such as vim or java
filetype on

" }}}

" Mappings --- {{{
 
" let : when pressing ;
nnoremap ; :

" To open _vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<cr>

" Sourcing Mapping
nnoremap <leader>sv :source $MYVIMRC<cr>

"adding double quotes to the current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"adding single quotes to the current word
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

"Adding quotes to whatever is selected in visual mode
:vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>

" Navigation H to the beginning of the current line
nnoremap H I<esc>

" Navigation L to the end of the current line
nnoremap L A<esc>

" Make <esc> be jk in insert mode.
inoremap jk <esc>


" Disabling mappings
" ==========================

inoremap <esc> <nop>

" Arrow keys disabled
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" }}}

" Abbreviations --- {{{
" Typos
iabbrev adn and
iabbrev waht what 
iabbrev tehn then
iabbrev dont don't
iabbrev doesnt doesn't

" helpful abbrevaitions
iabbrev @@ glm-wilson@hotmail.com
iabbrev ccopy Copyright 2015 Wilson Mateo, all rights reserved.  
iabbrev ssig -- <cr>Wilson Mateo<cr>glm-wilson@hotmail.com

" Programming abbreviations
" iabbrev { {<cr>}
" }}}

" Autocmds --- {{{
" Formatting .html files when we read and write a file
augroup formating_html
	autocmd!
	autocmd BufWritePre,BufRead *.html :normal gg=G
augroup  END

" no wrapping for all .html files.
augroup nowrap_html
	autocmd!
	autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END

" use <localleader>c to comment out a line in different languages
" ================================================================

" Autocmd-comments-spesific_files --- {{{
augroup java_comments
	autocmd!
	" Java .java autocomment.
	autocmd FileType java nnoremap <buffer> <localleader>c I//<space><esc>

	" JavaScript .js autocomment.
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<space><esc>

	"Python
	autocmd FileType python nnoremap <buffer> <localleader>c I#<space><esc>

	" Vim autocommentss
	autocmd FileType vim nnoremap <buffer> <localleader>c I"<space><esc>
augroup END

" }}}

" }}}

" Movement-onoremap --- {{{
" Only wors in line. (Not the next pair)
" erase inside ( ) 
onoremap in( :<c-u>normal! f(vi(<cr>
" erase inside { } 
onoremap in{ :<c-u>normal! f{vi{<cr>
" erase inside [ ] 
onoremap in[ :<c-u>normal! f[vi[<cr>

" = heading
"  heading movement key
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>

" Heading and ='s movement key
onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>

" - heading
" Heading movement key
onoremap ish :<c-u>execute "normal ?^--\\+$\r:nohlsearch\rkvg_"<cr>

" Heading and -'s movement key
onoremap ash :<c-u>execute "normal?^--\\+$\r:nohlsearch\rg_vk0"<cr>
" }}}

" Vimscripting file setting  ---------------------{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END 
" }}}

" Folding  JS--- {{{
function! JSFold()
	let line = getline(v:lnum)
	if match(line, '^\s*function') > -1
		return ">1"
	elseif match(line, '^\s*\(if\|for\)\s*(.*)') > -1
		return ">2"
	elseif match(line, '^.*function\s*(.*') > -1
		return ">al"
	else
		return "="
endfunction

autocmd FileType javascript setlocal foldmethod=expr foldexpr=JSFold()
" }}}

"Folding java ---  {{{
function! JavaFold()

	" storing line check
	let line = getline(v:lnum)

	" Regex variables
	let method_header = '^\s*\(public\|private\|protected\)\?\s*\(static\)\?\s*\(byte\|short\|int\|long\|float\|double\|char\|String\|boolean\|void\)\?\s\+\w\+(.*)\s*{\s*$'
	let if_for_case = '^\s*\(if\|for\)\s*(.\+)\s*{\s*$'

	" forlding  method headers and constructors
	if match(line, method_header) > -1
		return ">1"
	elseif match(line, '// variables') > -1
		return ">1"
	" Folding if, for and case statemetns
	 elseif match(line, if_for_case) > -1
		return ">3"
	 else
		return "="
	endif

endfunction

autocmd FileType java setlocal foldmethod=expr foldexpr=JavaFold()
" }}}

syntax on
