" enable syntax highlighting
syntax on

" Highlight redundant whitespaces and tabs.
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" use 4 spaces instead of tabs
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2 

" always show ^M in DOS files
set fileformats=unix

" my terminal is white on black
set background=dark
highlight Comment ctermbg=blue
highlight Comment ctermfg=white

" always show line and col number and the current command, set title
set ruler
set showcmd
set title titlestring=vim\ %f

" caseinsensitive incremental search
set ignorecase
set incsearch

" Show matching brackets
set showmatch

" disable any autoindenting which could mess with your mouse pastes (and your head)
" (not useing 'set paste' here to keep fancy stuff like tab completion working)
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent on
"filetype plugin indent off

" Get rid of folding
set nofoldenable

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
func! InsertTabWrapper()
    "let col = col('.') - 1
    "if !col || getline('.')[col - 1] !~ '\k'
    "    return \<tab>
    "else
    "    return \<c-p>
    "endif
return "\<tab>"
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
filetype on           " Enable filetype detection
filetype plugin on

" function to cleanup a text -> mapped to F5
fun CleanText()
    let curcol = col(".")
    let curline = line(".")
    exe ":retab"
    exe ":%s/^M$//ge"
    exe ":%s/^M/ /ge"
    exe ":%s/ \\+$//e"
    call cursor(curline, curcol)
endfun
map <F5> :call CleanText()<CR>

au BufNewFile,BufRead *.i set filetype=swig

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
"
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

map ,l :!latex %
:map \ld :execute '!xdvi -editor "vim --servername 'v:servername' --remote +\%l \%f" -sourceposition ' . line(".") . expand("%") . " '" . expand(Tex_GetMainFileName(':r')) . ".dvi' >/dev/null&" <CR><CR>

if (&tildeop)
  nmap gc guiw~l
  vmap gc gu~l
else
  nmap gc guiw~h
  vmap gc gu~h
endif

" Toggle function for spelling
" Read http://goo.gl/dE6PR before using!
func! ToggleSpl( lang )
if &l:spl =~ '\v(^|,)\V'.escape(a:lang,'\').'\v(,|$)'
"Alternatively, since 'spl' may not contain a comma this also
"works:
"if index(split(&l:spl,','),a:lang) != -1
exec 'setl spl-='.a:lang
else
exec 'setl spl+='.a:lang
endif
:setl spell spl
endfun

" Toggle german spelling
map <F3> :call ToggleSpl('de')<cr>
" Toggle english spelling
map <F4> :call ToggleSpl('en')<cr>



" Enable proper pasting, see http://goo.gl/YauET
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Enable 256 colors
set t_Co=256

" ruby autocompletion
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>
" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>
" Maps Alt-[n,p] for moving next and previous window respectively
map <silent> <A-n> <C-w><C-w>
map <silent> <A-p> <C-w><S-w>
