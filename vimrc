 " vim:foldmethod=marker
"piszur's Vim config
"https://github.com/piszur/vimconfig
"git clone https://github.com/piszur/vimconfig.git ~/.vim
"to ~/.vimrc file: runtime vimrc

"{{{ general
syntax on

set nocompatible                                 "use Vim settings, rather then Vi settings (much better!).

"activate pathogen runtimepath maneger:
execute pathogen#infect()

set history=1000                                 "the command-lines that you enter are remembered in a history table
set undolevels=1000                              "maximum number of changes that can be undone
set undodir=~/temp/vimundofiles                  "directory names for undo files
set undofile                                     "automatically saves undo history to an undo file when writing a buffer to a file

filetype on                                      "enable file type detection
filetype plugin on                               "enable loading the plugin files for specific file types
filetype indent on                               "enable loading the indent file for specific file types

set titlestring=%(\ %M%)\ %t%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ %{v:servername}
set title
set titlelen=70

set omnifunc=syntaxcomplete#Complete             "specifies a function to be used for insert mode omni completion
"filetype specific omni completion
autocmd FileType scss,less,css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,mustache,handlebars setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


"filetype specific setting
autocmd BufNewFile,BufRead *.sql setfiletype pgsql
" autocmd BufNewFile,BufRead *.sql setfiletype sqlanywhere
autocmd BufRead,BufNewFile jquery.*.js set filetype=javascript syntax=jquery
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd BufNewFile,BufRead **/Template/*.html set filetype=html.mustache
"}}}
"{{{ user interface

set scrolloff=5                                  "minimal number of screen lines to keep above and below the cursor
set sidescroll=1                                 "minimal number of columns to scroll horizontally
set sidescrolloff=10                             "minimal number of screen columns to keep to the left/right of the cursor

set novisualbell                                 "use visual bell instead of beeping

set ruler                                        "show the line and column number of the cursor position
set rulerformat=%-14.(%l,%c%V%)\ %P              "determines the content of the ruler string

set nohidden                                     "NO hide buffers when they are abandoned

set backspace=indent,eol,start                   "allow backspacing over autoindent, line breaks, start of insert
" set whichwrap=b,s,<,>,[,]                        "allow BS,Space,Left/Right keys that move the cursor the previous/next line when the cursor is on the end of the line

set showmatch                                    "when a bracket is inserted, briefly jump to the matching one
set ignorecase                                   "the case of normal letters is ignored in search pattern
set smartcase                                    "override 'ignorecase' if the search pattern contains upper case characters
if version >= 800
  set tagcase=followscs                            "follow the 'smartcase' and 'ignorecase' options when searching in tags files
endif
set report=0                                     "always report number of lines changed (message will be given for ":" commands)

set incsearch                                    "find the next match as we type the search
set hlsearch                                     "hilight searches by default

set showcmd                                      "show incomplete cmds down the bottom
set showmode                                     "show current mode down the bottom

"show relative line numbers (except insert mode, when show absolute line numbers):
set numberwidth=4                                "minimal number of columns to use for the line number
set relativenumber                               "show relative line numbers (set default)
autocmd InsertEnter,FocusLost,WinLeave * silent! :set number
autocmd InsertLeave,BufNewFile,BufRead,VimEnter,WinEnter * silent! :set relativenumber

set splitright                                   "splitting a window will put the new window right of the current one
" set splitbelow                                   "splitting a window will put the new window below the current one

set lazyredraw                                   "don't redraw while executing macros (good performance config)

" set magic                                        "for regular expressions turn magic on

let mapleader = ","                              "define a mapping which uses the special string '<Leader>' can be used
let g:mapleader = ","                            "define a mapping which uses the special string '<Leader>' can be used

if has('mouse')
  set ttyfast
  set ttymouse=xterm2
  set mouse=a                                    "enable the use of the mouse
endif

set fillchars=vert:\ ,stl:\ ,stlnc:\             "no fill character the statuslines and vertical separators

set nocursorcolumn                               "no highlight the screen column of the cursor
" set cursorcolumn                                 "highlight the screen column of the cursor
" highlight CursorLine term=none cterm=none ctermbg=3
" highlight CursorLine term=none gui=none guibg=3
set nocursorline                                 "no highlight the screen line of the cursor
" set cursorline                                   "highlight the screen line of the cursor
" highlight CursorLine term=none cterm=none ctermbg=3
" highlight CursorLine term=none gui=none guibg=3

"netrw bug correction:
autocmd BufEnter * :set nocursorline

set wildmenu                                     "command-line completion operates in an enhanced mode
" set wildmode=list:longest                      "complete till longest common string

"list of file patterns is ignored when completing file or directory names
set wildignore+=.hg,.git,.svn                    "version control
set wildignore+=*.aux,*.out,*.toc                "latex intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   "binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "compiled object files
set wildignore+=*.spl                            "compiled spelling word lists
set wildignore+=*.ods,*.odx,*.swf,*.swx          "document files
set wildignore+=*.doc,*.docx,*.xls,*.xlsx        "document files
set wildignore+=*.deb                            "package files
set wildignore+=*.sw?                            "Vim swap files
set wildignore+=*.DS_Store                       "OSX bullshit
set wildignore+=*.luac                           "Lua byte code
set wildignore+=migrations                       "Django migrations
set wildignore+=*.pyc                            "Python byte code
set wildignore+=*.orig                           "Merge resolution files

"stay cursor when quit to insert mode
" let CursorColumnI = 0 "the cursor column position in INSERT
" autocmd InsertEnter * let CursorColumnI = col('.')
" autocmd CursorMovedI * let CursorColumnI = col('.')
" autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

"effect in the GUI version of Vim
set guioptions=aegirLt                           "autoselect,tab page,grey menu,vim icon,right scrollbar,optional left scrollbar,tearoff
"set guioptions=aegirLtmT                           "autoselect,tab page,grey menu,vim icon,right scrollbar,optional left scrollbar,tearoff,menu,toolbar

"add menu and toolbar in the GUI version of Vim
nnoremap <F11> :set guioptions+=mT

" Zoom / Restore window in multiple windows mode.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <C-W>u :ZoomToggle<CR>

"}}}
"{{{ navigation

"easy access to jump to the exact mark
nnoremap <Tab> `
xnoremap <Tab> `

"move cursor by display lines when wrapping
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj
" inoremap <Up> <C-o>gk
" inoremap <Down> <C-o>gj
" TODO: http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping

"navigating to different tab (in normal and command mode)
" nnoremap <C-S-Left> <Esc>gT
" cnoremap <C-S-Left> <Esc>gT:
" nnoremap <C-S-Right> <Esc>gt
" cnoremap <C-S-Right> <Esc>gt:<C-R>:

"navigating to different window (in normal mode)
nnoremap <Tab><Up> <C-w>k
nnoremap <Tab><Down> <C-w>j
nnoremap <Tab><Left> <C-w>h
nnoremap <Tab><Right> <C-w>l

"moving cursor to next TODO
nnoremap <Tab><Space> :.,/todo\\|fixme/

"open Quickfix List window bottom and occupy the full width of the Vim window
" autocmd! BufEnter,BufRead,BufNewFile,BufReadPost  * :if &buftype is# 'quickfix' | nnoremap <Space><Space> :cclose<cr> | else | nnoremap <Space><Space> :botright copen 20<cr> | endif
autocmd! BufEnter,BufRead,BufNewFile,BufReadPost  * :if &buftype is# 'quickfix' | nnoremap qq :cclose<cr>  | nnoremap <Space><Space> :lclose<cr>| else | nnoremap qq :botright copen 20<cr> | nnoremap <Space><Space> :lopen<cr>| endif

"moving cursor after the next |
" nnoremap <Tab>| /|/e+1<cr>

"}}}
"{{{ editor settings

"drag single lines (or lines in linewise-visual and blockwise-visual mode)
nmap <C-Up> :m-2<CR>
inoremap <C-Up> <Esc>:m-2<CR>
vnoremap <C-Up> :m-2<CR>gv
nmap <C-Down> :m+<CR>
inoremap <C-Down> <Esc>:m+<CR>
vnoremap <C-Down> :m'>+<CR>gv

"delete line(s) and move into register Black Hole]
nnoremap DD "_dd

"change text objects from clipboard
nnoremap cp" ci"<C-R>0<ESC>
nnoremap cp' ci'<C-R>0<ESC>
nnoremap cp( ci(<C-R>0<ESC>
nnoremap cp[ ci[<C-R>0<ESC>
nnoremap cp< ci<<C-R>0<ESC>
nnoremap cp{ ci{<C-R>0<ESC>
nnoremap cpw ciw<C-R>0<ESC>
nnoremap cpt cit<C-R>0<ESC>

"insert current file name
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:t:r') : '%%'
inoremap <expr> <C-r>%% expand('%:t:r')

"insert full path of current file name
cnoremap <expr> %/ getcmdtype() == ':' ? expand('%:h').'/' : '%/'
inoremap <expr> <C-r>%/ expand('%:h').'/'

"insert alternate file name
cnoremap <expr> ## getcmdtype() == ':' ? expand('#:t') : '##'
inoremap <expr> <C-r>## expand('#:t')

"insert full path of alternate file name
cnoremap <expr> #/ getcmdtype() == ':' ? expand('#:h').'/' : '#/'
inoremap <expr> <C-r>#/ expand('#:h').'/'

"automatic close brackets
" inoremap {              {}<Left>
" inoremap {<CR>          {<CR>}<Esc>O
" inoremap {<Right>       {<Right>
" inoremap {<Left>        {<Left>
" inoremap {<End>         {<End>
" inoremap {<End><End>    {<End>}
" inoremap {}             {}
" inoremap (              ()<Left>
" inoremap (<CR>          (<CR>)<Esc>O
" inoremap (<Right>       (<Right>
" inoremap (<Left>        (<Left>
" inoremap (<End>         (<End>
" inoremap (<End><End>    (<End>)
" inoremap ()             ()
" inoremap [              []<Left>
" inoremap [<CR>          [<CR>]<Esc>O
" inoremap [<Right>       [<Right>
" inoremap [<Left>        [<Left>
" inoremap [<End>         [<End>
" inoremap [<End><End>    [<End>]
" inoremap []             []

iabbrev d: <C-r>=strftime("%G.%m.%d")<CR>
iabbrev D: <C-r>=strftime("%G %B %d, %A")<CR>
iabbrev t: <C-r>=strftime("%R")<CR>
iabbrev T: <C-r>=strftime("%T")<CR>
iabbrev dt: <C-r>=strftime("%G.%m.%d %R")<CR>
iabbrev DT: <C-r>=strftime("%G %B %d, %A %T")<CR>

"panic button (Rot13 encode;)
nnoremap <C-F12> mtggg?G`t

"XML format entire buffer
command! XMLformat %!xmllint --format --recover -

"change upper case for SQL command (experimental, not perfect)
command! SQLUppercase s/\<\w\+\>/\=synIDattr(synID(line('.'),col('.'),1), 'name')=~'sql\%(keyword\|operator\|statement\)'?toupper(submatch(0)):submatch(0)/g

"}}}
"{{{ tab and indent related

set shiftwidth=2                                 "number of spaces to use for each step of (auto)indent
set tabstop=2                                    "Number of spaces that a <Tab> in the file counts for
set softtabstop=2                                "number of spaces that a <Tab> counts
set expandtab                                    "in insert mode: use spaces to insert a <Tab>
set autoindent                                   "copy indent from current line when starting a new line
set smartindent                                  "do smart autoindenting when starting a new line
set smarttab                                     "a <Tab> in front of a line inserts blanks according to 'shiftwidth'

set nowrap                                       "dont wrap lines
autocmd FileType text setlocal wrap              "wrap lines in text file
set breakindent                                  "wrapped line repeats indent

set linebreak                                    "wrap lines at convenient points
set showbreak=+++                                "string to put at the start of lines that have been wrapped.
" set textwidth=200                                "maximum width of text that is being inserted
" set wrapmargin=2                                 "number of characters from the right window border where wrapping starts

"display tabs and trailing spaces:
" set list
" set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set listchars=nbsp:¬,eol:¶,tab:→\ ,extends:»,precedes:«,trail:⋅

"shift line(s) in visual mode
vnoremap < <gv
vnoremap > >gv

"}}}
"{{{ visual mode related

"begin visual mode and select previous/next word in normal mode
" nnoremap <S-Left> vb
" nnoremap <S-Right> vw

"select previous/next WORD in visual mode
" vnoremap <C-S-Left> B
" vnoremap <C-S-Right> W

"select precedence/next line in normal and visual mode
" nnoremap <S-Up> Vk
" vnoremap <S-Up> k
" nnoremap <S-Down> Vj
" vnoremap <S-Down> j

"fix linewise visual selection of various text objects
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

"select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

"minden másolása rendszervágólapra 'a-tól 'z-ig
nnoremap yz mtg'a"+yg'zg`t
nnoremap <C-y>z mtg'a"+yg'zg`t

"}}}
"{{{ search and replace

"hide search highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:call clearmatches()<CR>

"replace a match of word nearest to the cursor
noremap // "syiw:%S/<C-r>s//gc<Left><Left><Left>
vnoremap // "sy:%S/<C-r>s//gc<Left><Left><Left>

"replace a match of word nearest to the cursor (with default value)
noremap /// "syiw:%S/<C-r>s/<C-r>s/gc<Left><Left><Left>
vnoremap /// "sy:%S/<C-r>s/<C-r>s/gc<Left><Left><Left>

"count a match of word nearest to the cursor
nnoremap ?? :%s/\<<C-R><C-W>\>/&/gn<CR>
vnoremap ?? y:%s/\<<C-R>"\>/&/gn<CR>

"count a match of word nearest to the cursor (search also find matches that are not a whole word)
nnoremap ??? :%s/<C-R><C-W>/&/gn<CR>
vnoremap ??? y:%s/<C-R>"/&/gn<CR>

" set args from the quickfix list (for the argdo search and replace)
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" set args from the quickfix list (for the argdo search and replace)
command! -nargs=0 -bar Largs execute 'args' LocationFilenames()
" populate the argument list with each of the files named in the quickfix list
function! LocationFilenames()
  let buffer_numbers = {}
  for location_item in getloclist(0)
    let buffer_numbers[location_item['bufnr']] = bufname(location_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"show CSS color code in browser
"}}}
"{{{ manage clipboard

"specifies the key sequence that toggles the 'paste' option
set pastetoggle=<F4>                             "only in insert mode
nnoremap <F4> :set invpaste paste?<CR>

"yank text from cursor to end of line
nnoremap Y y$

"yank using the system clipboard
vnoremap <C-y> "+y
nnoremap <C-y> "+y
nnoremap <C-y><C-y> "+yy

"paste using the system clipboard
vnoremap <C-p> d"+P`[v`]
nnoremap <C-p> "+P
inoremap <C-p> <C-O>:set paste<CR><C-r>+<C-O>:set nopaste<CR>

"visually select the text that was last edited/paste
nnoremap gp `[v`]
vnoremap p p`[v`]
vnoremap P P`[v`]

"yank current filename or path using the system clipboard
nnoremap <silent> y% :let @+=expand("%")<CR>
nnoremap <silent> y%/ :let @+=expand("%:h")<CR>
nnoremap <silent> y%% :let @+=expand("%:t:r")<CR>

"yank alternate filename or path using the system clipboard
nnoremap <silent> y# :let @+=expand("#")<CR>
nnoremap <silent> y#/ :let @+=expand("#:h")<CR>
nnoremap <silent> y## :let @+=expand("#:t")<CR>

"}}}
"{{{ files and backups

let g:netrw_list_hide= '.*\.sw[p|o]$'            "list for hiding files in netrw

"sudo saves the file (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

"write file when the buffer has been modified
nnoremap <silent> <F2> :update<CR>
inoremap <silent> <F2> <c-o>:update<CR>

"open file in new window
nnoremap <C-S-g> <C-w>gf

"change to directory of current file
command! CDC cd %:p:h

"}}}
"{{{ spell checking

set nospell spelllang=hu                         "disable spell checking, and setting word list
autocmd FileType text setlocal spell             "check spell in text file
autocmd FileType help setlocal nospell           "disable spell checking in help file

scriptencoding utf-8
set encoding=utf-8

"}}}
"{{{ folder options

" set foldcolumn=4                                 "add a bit extra margin to the left

set foldmethod=syntax                            "syntax highlighting items specify folds
" set foldmethod=indent                          "lines with equal indent form a fold
autocmd FileType xml setlocal foldmethod=syntax  "forced syntax highlighting in XML

set foldlevelstart=1                             "sets 'foldlevel' when starting to edit buffer
" set foldnestmax=3                              "deepest fold is 3 levels
" set nofoldenable                               "dont fold by default
let g:javascript_fold=1                          "JavaScript
let g:perl_fold=1                                "Perl
let g:php_folding=1                              "PHP
let g:r_syntax_folding=1                         "R
let g:ruby_fold=1                                "Ruby
let g:sh_fold_enabled=1                          "sh
let g:vimsyn_folding='af'                        "Vim script
let g:xml_syntax_folding=1                       "XML

function! GetPerlFold()
  if getline(v:lnum) =~ '^\s*sub\s'
    return ">1"
  elseif getline(v:lnum) =~ '\}\s*$'
    let my_perlnum = v:lnum
    let my_perlmax = line("$")
    while (1)
      let my_perlnum = my_perlnum + 1
      if my_perlnum > my_perlmax
        return "<1"
      endif
      let my_perldata = getline(my_perlnum)
      if my_perldata =~ '^\s*\(\#.*\)\?$'
        " do nothing
      elseif my_perldata =~ '^\s*sub\s'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction

"set syntax highlighting in perl
autocmd BufEnter *.pm :setlocal foldexpr=GetPerlFold()
autocmd BufEnter *.pm :setlocal foldmethod=expr

"close fold in read vimrc
autocmd BufRead ~/.vim/vimrc normal zm
autocmd BufRead ~/.nvim/vimrc normal zm

"}}}
"{{{ color schema and custom colors

if $COLORTERM == 'gnome-terminal' || has('gui_running')
  set t_Co=256                                   "number of colors available in terminal
  colorscheme gruvbox                               "set 'gruvbox' color scheme
else
  set t_Co=16                                    "number of colors available in gui
  colorscheme desert                               "set 'desert' color scheme
endif
"set foreground and background
set background=dark                              "Vim will try to use colors that look good on a dark background
highlight Normal ctermfg=white ctermbg=NONE
highlight Normal guifg=white guibg=black

"line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set
highlight LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
highlight LineNr guifg=#555555 guibg=NONE gui=NONE
"last search pattern highlighting
if $COLORTERM == 'gnome-terminal' || has('gui_running')
  highlight Search ctermfg=lightblue ctermbg=black
else
  highlight Search ctermfg=black ctermbg=lightblue
  highlight IncSearch ctermfg=black ctermbg=yellow
endif
highlight Search guifg=#afffff guibg=black

"column where signs are displayed
highlight SignColumn ctermfg=lightgrey ctermbg=black cterm=bold
highlight SignColumn guifg=lightgrey guibg=#111111 gui=bold
"popup menu: normal item
highlight Pmenu ctermbg=lightblue ctermfg=black cterm=NONE
highlight Pmenu guibg=#afffff guifg=black gui=NONE
"popup menu: selected item
highlight PmenuSel ctermbg=darkblue ctermfg=white cterm=bold
highlight PmenuSel guibg=#3465a4 guifg=white gui=bold
"tab pages line, where there are no labels
highlight clear TabLineFill
highlight TabLineFill ctermfg=gray ctermbg=darkgrey cterm=NONE
highlight TabLineFill guifg=gray guibg=darkgrey gui=NONE
"tab pages line, not active tab page label
highlight clear TabLine
highlight TabLine ctermfg=gray ctermbg=darkgrey cterm=NONE
highlight TabLine guifg=gray guibg=darkgrey gui=NONE
"tab pages line, active tab page label
highlight clear TabLineSel
highlight TabLineSel ctermfg=white ctermbg=none cterm=bold
highlight TabLineSel guifg=white guibg=black gui=bold
"folded highlighting
highlight Folded guibg=#212121 guifg=#55574c
"after end of file
highlight NonText guibg=black guifg=#9999ff
"color of commands
highlight Statement guifg=#c4a000

syntax sync fromstart                            "refresh syntact highlighting
noremap <silent> <F12> <Esc>:syntax sync fromstart<CR>:let &l:statusline = g:Active_statusline<CR>:redraw!<CR>
inoremap <silent> <F12> <C-o>:syntax sync fromstart<CR><C-o>:let &l:statusline = g:Active_statusline<CR><C-o>:redraw!<CR>

syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo
"}}}
"{{{ status line

set laststatus=2                                 "always show statusline (precedence over 'ruler' and 'rulerformat')

" a státuszsor bal szélének színe megváltozik beszúrás módban
highlight clear StatusLine

highlight StatusLine ctermfg=white ctermbg=NONE
highlight StatusLine guifg=white guibg=NONE

highlight StatusLineNC cterm=NONE ctermfg=grey ctermbg=darkgrey
highlight StatusLineNC gui=NONE guifg=grey guibg=#2e3436

autocmd InsertEnter * highlight User1 ctermfg=black ctermbg=lightblue cterm=NONE cterm=NONE
autocmd InsertEnter * highlight User1 guifg=black guibg=#84a598 gui=NONE gui=NONE

autocmd InsertEnter * highlight User2 ctermfg=lightblue ctermbg=NONE cterm=NONE
autocmd InsertEnter * highlight User2 guifg=#84a598 guibg=NONE gui=NONE

autocmd InsertLeave * highlight User1 ctermfg=black ctermbg=250 cterm=NONE
autocmd InsertLeave * highlight User1 guifg=black guibg=#a89985 gui=NONE

autocmd InsertLeave * highlight User2 ctermfg=250 ctermbg=NONE cterm=NONE
autocmd InsertLeave * highlight User2 guifg=#a89985 guibg=NONE gui=NONE

highlight User1 ctermfg=black ctermbg=250 cterm=NONE    " bal oldal normál szöveg
highlight User1 guifg=black guibg=#a89985 gui=NONE          " bal oldal normál szöveg

highlight User2 ctermfg=250 ctermbg=NONE cterm=NONE     " bal oldal záróelem
highlight User2 guifg=#a89985 guibg=NONE gui=NONE           " bal oldal záróelem

highlight User3 ctermfg=black ctermbg=250 cterm=NONE    " jobb oldal normál szöveg
highlight User3 guifg=black guibg=#a89985 gui=NONE          " jobb oldal normál szöveg

highlight User4 ctermfg=250 ctermbg=NONE cterm=NONE     " jobb oldal záróelem
highlight User4 guifg=#a89985 guibg=NONE gui=NONE           " jobb oldal záróelem

highlight User5 ctermfg=black ctermbg=250 cterm=NONE    " jobb oldal elválasztó
highlight User5 guifg=black guibg=#a89985 gui=NONE          " jobb oldal elválasztó

highlight User6 ctermfg=242 ctermbg=NONE cterm=NONE     " alap másodlagos
highlight User6 guifg=#887965 guibg=NONE gui=NONE           " alap másodlagos

highlight User7 ctermfg=darkgrey ctermbg=black cterm=NONE      " inkatív elválasztó
highlight User7 guifg=#555753 guibg=#2e3436 gui=NONE            " inkatív elválasztó

highlight User8 ctermfg=white ctermbg=black cterm=NONE         " inkatív jobb oldal
highlight User8 guifg=white guibg=#2e3436 gui=NONE               " inkatív jobb oldal

highlight User9 ctermfg=lightgrey ctermbg=darkgrey cterm=NONE  " inaktív bal oldal
highlight User9 guifg=lightgrey guibg=#555753 gui=NONE        " inaktív bal oldal

" statusline:
let &statusline="%1*"
               \."%n\ "
               \."〉"
               \."%m"
               \."%R\ "
               \."%Y\ "
               \."%*"
               \."%2*▶\ %*"
               \."%6*"
               \."%{exists('g:loaded_fugitive')?''.fugitive#head(20).' ':''}"
               \."%*"
               \."%<"
               \."%f"
               \."%6*"
               \."\ (%{&spelllang})"
               \."%w"
               \."%q"
               \."%*"
               \."%="
               \."%4*◀%*"
               \."%3*"
               \."\ %{''.(&fenc!=''?&fenc:&enc).''}"
               \."\ 〈"
               \."\%{&ff}"
               \."\ 〈"
               \."%("
               \."%L"
               \."/%P"
               \."%)"
               \."\ 〈"
               \."%3*%9("
               \."%l"
               \."/"
               \."%-4v"
               \."%)"
               \."〈"
               \."%{strftime(\"%H:%M\ \")}"
               \."%*"

let g:Active_statusline=&g:statusline
let g:NCstatusline="%9*%n\ "
               \."〉"
               \."%m"
               \."%R\ "
               \."%Y\ %*"
               \."%7*▶\ %*"
               \."%8*%<"
               \."%f"
               \."\ "
               \."%w"
               \."%q"
               \."%=%*"
               \."%7*◀%*"
               \."%9*\ "
               \."%L"
               \."/%P"
               \."\ 〈"
               \."%5l"
               \."/"
               \."%-5v"
               \."〈"
               \."%{strftime(\"%H:%M\ \")}%*"

autocmd WinEnter * let &l:statusline = g:Active_statusline
autocmd WinLeave * let &l:statusline = g:NCstatusline

" chr ascii:%b
" chr hexa:0x%04B
"
" PL ◀ 9664 PR ▶ 9654  <H ☜ 9756 >H ☞ 9758  *- ∗ 8727  </ 〈 9001 /> 〉 9002  ◢ Σ

function! WindowNumber()
  let str = ''
  if winnr('$') != 1
    let str = winnr()
  endif
  return str
endfunction


"}}}
"{{{ plugin settings

"plugin/highlight_matches.vim                    "rewires n and N to do the highlighing...
"plugin/visualstar.vim                           "allows you to select some text using Vim's visual mode and then hit * and #
"plugin/matchit.vim                              "allows you to configure % to match more than just single characters
"plugin/sourcebeautify/sourcebeautify.vim        "beautify your javascript,html,css source code inside Vim
autocmd BufRead,BufNewFile *.json setf json

"bundle/vim-repeat                               "use the repeat command (.) with supported plugins
"bundle/vim-snipmate                             "using TextMate-style snippets in Vim (in vim-snippets and bob_snippets)
"bundle/vim-addon-mw-utils                       "interpret a file by function and cache file automatically (snipmate dependency)
"bundle/tlib_vim                                 "this library provides some utility functions (snipmate dependency)
"bundle/vim-snippets                             "general snippet collection
"bundle/bob_snippets                             "BOB specific snippets
"bundle/vim-abolish                              "easily search for, substitute, and abbreviate multiple variants of a word
"bundle/vim-surround                             "delete/change/add parentheses/quotes/XML-tags/much more with ease
"bundle/vim-javascript                           "vastly improved Javascript indentation and syntax support in Vim
"bundle/tabular                                  "text filtering and alignment
"bundle/rename                                   "rename a buffer within Vim and on the disk
"bundle/camelcasemotion                          "motion through CamelCaseWords and underscore_notation
"bundle/vim-backbone                             "Lightweight bag of Vim utilities for Backbone
"bundle/vim-projectionist                        "Quickly edit project files using the .projections.json format
"bundle/gruvbox                                  "Retro groove color scheme for Vim
"bundle/vim-bootstrap4-snippets                  "Bootstrap 4 markup snippets for Vim
"bundle/vim-exchange                             "Easy text exchange operator for Vim
"bundle/vorg                                     "The plain text organizer for ViM
"bundle/vim-css3-syntax                          "CSS3 syntax (and syntax defined in some foreign specifications) support
"bundle/vim-sass-colors                          "Highlight sass colors and color variables
"bundle/scss-syntax.vim                          "Vim syntax file for scss (Sassy CSS)
"bundle/vim-better-javascript-completion         "An expansion of Vim's current JavaScript syntax file
"bundle/textobj-word-column.vim                  "Adds text-objects for word-based columns in Vim
"bundle/vim-indent-object                        "defines a new text object representing lines of code at the same indent level
"bundle/vim-indent-object                        "defines a new text object representing lines of code at the same indent level
"bundle/agrep                                    "Asynchronous grep plugin for Vim

"bundle/mustache                                 "mustache and handlebars mode for vim
let g:mustache_abbreviations = 1

"bundle/vim-textobj-user                         "Create your own text objects
call textobj#user#plugin('mustachevalue', {
\   'code': {
\     'pattern': ['}}', '{{'],
\     'select-a': 'aT',
\     'select-i': 'iT',
\   },
\ })

"bundle/javascript-libraries-syntax.vim          "syntax for JavaScript libraries
let g:used_javascript_libs = 'jquery,underscore,backbone'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 0

"bundle/incsearch                                "incrementally highlights ALL pattern matches unlike default 'incsearch'
let g:incsearchOn = 0
let g:incsearch#auto_nohlsearch = 1
nnoremap <expr> ,/ g:incsearchOn==1 ? ':let g:incsearchOn=0<CR>' : ':let g:incsearchOn=1<CR>'
map <expr> / g:incsearchOn==1 ? '<Plug>(incsearch-forward)' : '/'
map <expr> ? g:incsearchOn==1 ? '<Plug>(incsearch-backward)' : '?'
map z/ <Plug>(incsearch-stay)
map <expr> n g:incsearchOn==1 ? '<Plug>(incsearch-nohl-n)' : 'n'
map <expr> N g:incsearchOn==1 ? '<Plug>(incsearch-nohl-N)' : 'N'

"bundle/vim-asterisk                             "provides improved * motions
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

"bundle/vim-over
nnoremap g/ :OverCommandLine<CR>%s//
" vnoremap g/ :OverCommandLine<CR>'<,'>s//
vnoremap g/ :OverCommandLine<CR>s//

"bundle/l9                                       "Vim-script library (fuzzyfinder dependency)
"bundle/fuzzyfinder                              "buffer/file/command/tag/mru/etc explorer with fuzzy matching
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 1000
let g:fuf_mrucmd_maxItem = 400
let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
" let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*\|*.sw[p|o]$'
nnoremap <silent> <Leader>ff :FufFileWithCurrentBufferDir!<CR>
nnoremap <silent> <Leader>fF :FufFileWithFullCwd!<CR>
nnoremap <silent> <Leader>f: :FufMruCmd<CR>
nnoremap <silent> <Leader>f. :FufChangeList<CR>
nnoremap <silent> <Leader>fl :FufLine<CR>
nnoremap <silent> <Leader>fm :FufMruFileInCwd<CR>
nnoremap <silent> <Leader>fM :FufMruFile<CR>
nnoremap <silent> <Leader>fh :FufHelpWithCursorWord<CR>
" let g:fuf_keyOpenTabpage = ?

"bundle/vim-fugitive                             "the best Git wrapper of all time
" set diffopt+=vertical                            "Gdiff split window vertical
autocmd BufReadPost fugitive://* set bufhidden=delete

"bundle/bufexplorer                              "you can quickly and easily switch between buffers
" nmap <Tab>00 <Leader>bs
let g:bufExplorerSplitBelow=1                    "split new window below current
let g:bufExplorerSplitHorzSize=20                "new split window is n rows high.
nnoremap <silent> <Tab>00 :BufExplorerHorizontalSplit<CR>

"bundle/nerdtree                                 "a tree explorer plugin for navigating the filesystem
let NERDTreeIgnore=['\.sw.\?$', '\~$']

"bundle/nerdtree-execute                         "plugin for NERD Tree that provides an execute menu item,
                                                 "that executes system default application for file or directory

"bundle/vim-speeddating                          "use CTRL-A/CTRL-X to increment dates, times, and more
autocmd BufEnter * :SpeedDatingFormat %y.%m.%d
autocmd BufEnter * :SpeedDatingFormat %Y.%m.%d
autocmd BufEnter * :SpeedDatingFormat %Y.%m.%d[ T_-]%H:%M
autocmd BufEnter * :SpeedDatingFormat %H:%M

"bundle/vim-easymotion                           "Vim motions on speed
nmap <Tab><Tab> <Plug>(easymotion-prefix)
nmap <Leader><Leader> <Plug>(easymotion-prefix)
nmap <Tab><Tab><Tab> <Plug>(easymotion-repeat)
nmap <Tab><Tab>f <Plug>(easymotion-bd-f)
nmap <Tab><Tab>t <Plug>(easymotion-bd-t)
nmap <Tab><Tab>w <Plug>(easymotion-bd-w)
nmap <Tab><Tab>W <Plug>(easymotion-bd-W)
nmap <Tab><Tab>e <Plug>(easymotion-bd-e)
nmap <Tab><Tab>E <Plug>(easymotion-bd-E)
nmap <Tab><Tab>n <Plug>(easymotion-bd-n)

"bundle/vim-multiple-cursors
nnoremap <C-n><C-n> :%MultipleCursorsFind \<<C-r><C-w>\><CR>
vnoremap <C-n><C-n> y:%MultipleCursorsFind <C-R>"<CR>

"bundle/delimitMate-master                       "provides insert mode auto-completion for quotes, parens, brackets, etc
autocmd FileType vim let b:delimitMate_autoclose=0

"bundle/better-whitespace                        "all trailing whitespace characters (spaces and tabs) to be highlighted
nnoremap <silent> d<Space> :StripWhitespace<CR>
" CurrentLineWhitespaceOff hard

"bundle/vim-commentary                           "comment stuff out (gc,gcc,etc.)
autocmd FileType sql set commentstring=--\ %s

"bundle/syntastic                                "syntax checking hacks for vim
let g:syntastic_enable_signs = 1                 "mark lines with errors and warnings in the sign column
let g:syntastic_auto_jump = 2                    "jumping to the first error reported by a check

"bundle/vim_json                                 "better JSON: highlighting, JSON-specific (non-JS) warnings, quote concealing
highlight link jsonKeyword Special
let g:vim_json_syntax_conceal = 0

"bundle/open-browser                             "open URI/URL with default browser
let g:netrw_nogx = 1                             "disable netrw's gx mapping
"if it looks like URI, open URI under cursor, otherwise search word under cursor
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"plugin/taglist.vim                              "source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
let g:Tlist_WinWidth = 40                        "changing the window width
nnoremap <silent> <F8> :TlistToggle<CR>

"plugin/gundo.vim                                "visualizing undo tree to make it usable
nnoremap <silent> <F3> :GundoToggle<CR>
let g:gundo_width = 40                           "set the horizontal width of the Gundo graph (and preview)
let g:gundo_preview_height = 20                  "set the vertical height of the Gundo preview
let g:gundo_close_on_revert = 1                  "automatically close the Gundo windows when reverting
let g:gundo_playback_delay = 100                 "delay in milliseconds between each change when running 'play to' mode

"plugin/showmarks.vim                            "visually shows the location of marks
let g:showmarks_textlower="\t>"                  "defines how the mark is to be displayed
let g:showmarks_textupper=">>"                   "same as above but for the marks A-Z

highlight default ShowMarksHLl ctermfg=darkblue ctermbg=black cterm=inverse,bold
highlight default ShowMarksHLl guifg=blue guibg=#2e3436 gui=inverse,bold

highlight default ShowMarksHLu ctermfg=darkblue ctermbg=black cterm=inverse,bold
highlight default ShowMarksHLu guifg=blue guibg=#2e3436 gui=inverse,bold

highlight default ShowMarksHLo ctermfg=lightblue ctermbg=black cterm=bold
highlight default ShowMarksHLo guifg=lightblue guibg=#2e3436 gui=bold

highlight default ShowMarksHLm ctermfg=darkblue ctermbg=black cterm=bold
highlight default ShowMarksHLm guifg=blue guibg=#2e3436 gui=bold

"plugin/mru.vim                                  "manage Most Recently Used files
" let MRU_File = '~/.vim/_vim_mru_files'         "recently used filenames are stored in this file
let MRU_Max_Entries = 1000                       "remember 1000 most recently used file names
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*\|*.sw[p|o]$'
let MRU_Window_Height = 20                       "set height of the MRU window
let MRU_Use_Current_Window = 0                   "MRU plugin to reuse the current window
"configure mapping to open MRU window:
nnoremap '00 :MRU<CR>
"configure mapping in MRU window
autocmd BufNewFile,BufRead __MRU_Files__ nnoremap <buffer> <Esc>A k
autocmd BufNewFile,BufRead __MRU_Files__ nnoremap <buffer> <Esc>B j
autocmd BufNewFile,BufRead __MRU_Files__ nnoremap <buffer> <Esc>C l
autocmd BufNewFile,BufRead __MRU_Files__ nnoremap <buffer> <Esc>D h

"plugin/html_autoclosetag.vim                  "automatically closes XML/HTML tags once you finish typing them
autocmd FileType xhtml,xml source ~/.vim/plugin/html_autoclosetag.vim

"}}}
"{{{ Javascript
autocmd FileType javascript setlocal iskeyword-=.
autocmd BufNewFile,BufRead,BufEnter *.js normal zR
"}}}
"{{{ CSS, Scss  and LessCSS

augroup ft_css
  "remove all autocommands for the current group
  autocmd!

  autocmd BufNewFile,BufRead *.less setlocal filetype=less
  autocmd BufNewFile,BufRead *.scss setlocal filetype=css

  autocmd Filetype scss,less,css setlocal foldmethod=marker
  autocmd Filetype scss,less,css setlocal foldmarker={,}
  " autocmd Filetype scss,less,css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd Filetype scss,less,css setlocal iskeyword+=-

  "use <Leader>S to sort properties:
  autocmd BufNewFile,BufRead *.scss,*.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  "insert a pair of brackets in such a way that the cursor is correctly positioned inside of them AND the following code doesn't get unfolded
  "autocmd BufNewFile,BufRead *.scss,*.less,*.css inoremap <buffer> {<CR> {}<left><CR><space><space><space><space>.<CR><esc>kA<bs>
  "autocmd BufNewFile,BufRead *.scss,*.less,*.css inoremap <buffer> {<CR> {}<left><CR><space><space>.<CR><esc><left>i<bs><bs><esc>kA<bs>
  autocmd BufNewFile,BufRead *.scss,*.less,*.css inoremap <buffer> {<CR> {}<left><CR><space><space>.<CR><home><esc>kA<bs>

augroup END

"}}}
"{{{ JSON settings

augroup json_autocmd
  autocmd!
  autocmd FileType json setlocal formatoptions=tcq2l
  autocmd FileType json setlocal foldmethod=syntax
  " autocmd FileType json set conceallevel=0
augroup END

"}}}
"{{{ templater settings

autocmd BufNewFile,BufRead *.tmpl call s:AdjustTT2Type()
autocmd BufNewFile,BufRead *.tt call s:AdjustTT2Type()
let b:tt2_syn_tags = '\[% %] <!-- -->'

"use <leader><Ins> to insert template markers
autocmd FileType html,tt2,tt2html inoremap <Leader><Ins> [%  %]<left><left><left>
autocmd FileType tt2,tt2html inoremap <Leader><Ins><Ins> [% lang. %]<left><left><left>

autocmd FileType html.ep inoremap <Leader><Ins> <%=  %><left><left><left>
autocmd FileType html.ep inoremap <Leader><Ins><Ins> <%= l '' %><left><left><left><left>
autocmd FileType html,mustache,handlebars inoremap <Leader><Ins> {{}}<left><left>
autocmd FileType html,mustache,handlebars vnoremap <Leader><Ins> "sygvc{{<C-r>s}}<left><left><Esc>
autocmd FileType html,mustache,handlebars inoremap <Leader><Ins><Ins> {{#i18n}}{{/i18n}}<left><left><left><left><left><left><left><left><left>
autocmd FileType html,mustache,handlebars vnoremap <Leader><Ins><Ins> "sygvc{{#i18n}}<C-r>s{{/i18n}}<left><left><left><left><left><left><left><left><left><Esc>

autocmd FileType javascript inoremap <Leader><Ins> {{}}<left><left>
autocmd FileType javascript inoremap <Leader><Ins><Ins> {{#i18n}}{{/i18n}}<left><left><left><left><left><left><left><left><left>

func! s:AdjustTT2Type()
    if ( getline(1) . getline(2) . getline(3) =~ '<\chtml' && getline(1) . getline(2) . getline(3) !~ '<[%?]' ) || getline(1) =~ '<!DOCTYPE HTML'
        setfiletype tt2html
    else
        setfiletype tt2
    endif
endfunc

"}}}
"{{{ BOB specific settings

"see: bundle/bob_snippets                        "BOB specific snippets

" preparate commit
autocmd BufEnter **/.git/COMMIT_EDITMSG %s/#\t/\t/ | normal gg9j

" run 'daráló'
" map <C-S-F5> :!/home/fejleszto/munka/refresh_functions_fter.sh fter_kv^M
" map <C-S-F6> :!/home/fejleszto/munka/refresh_functions_fter_bcs.sh fter^M

" autocmd FileType sql :iabbrev <buffer> sl_ simplelist_
" autocmd FileType sql :iabbrev <buffer> spl_ speciallist_

autocmd BufNewFile **/global/dbxml/*.xml 0r ~/.vim/skeletons/dbxml.xml | :%foldopen
autocmd BufNewFile **/global/sql/*.sql 0r ~/.vim/skeletons/sql.sql | 7j
autocmd BufNewFile *.sql 0r ~/.vim/skeletons/sql.sql | 7j
autocmd BufNewFile **/global/sqldata/*.sql 0r ~/.vim/skeletons/sql.sql | 7j
autocmd BufNewFile **/global/xmlschema/*/history.xml 0r ~/.vim/skeletons/history.txt
autocmd BufNewFile *.html 0r ~/.vim/skeletons/html.html | 14j$

" autocmd BufRead **/global/sql/*.sql silent! normal gg/--\/\*\{4\}.\* SQL\//e+1ma
" autocmd BufRead **/global/sql/*.sql silent! normal gg/^\(DROP SEQUENCE\|BEGIN\)/mb
" autocmd BufRead **/global/sql/*.sql silent! normal gg/^CREATE \(OR REPLACE FUNCTION\|TABLE\) /e+1mc
" autocmd BufRead **/global/sql/*.sql silent! normal gg/--\*\s\+DESCRIPTION/e+1md
" autocmd BufRead **/global/sql/*.sql silent! normal gg/--\*\s\+\(NOTES\|Hibakódok:\)/eme
" autocmd BufRead **/global/sql/*.sql silent! normal gg/\(LANGUAGE plpgsql.*;\|--\*\*\*\*\/\)/emmz
" autocmd BufRead **/global/sql/*.sql silent! let @/ = histget("search",-3)
" autocmd BufRead **/global/sql/*.sql silent! normal `"
" autocmd BufRead **/global/sql/*.sql syntax sync fromstart

"load SQL keywords abbreviations
source ~/.vim/abbreviation_sql.vim

"load PgAdmin clone ;P
source ~/.vim/pgadmin.vim

" get count of pattern in document for template system
function! GetCount(myPattern)
    let pos=getpos('.')
    try
        redir => subscount
        execute 'silent %s/' . a:myPattern . '/&/gne'
        redir END
        let result=matchstr(subscount, '\d\+')
        return result == '' ? 0 : result
    finally
        call setpos('.', pos)
    endtry
endfunction


" get SQL info from 'FROM' in actual paragraph
" 'table' - name of function
" 'alias' - alias of function
" 'schema' - schema name
" 'parameter' - parameters of function
function! GetTablename(myPart)
    let pos=getpos('.')
    if a:myPart == 'table'
      let myPattern = 'FROM [^.]*\..*\(list\|read\|filter\|get\)_\zs[^(]*\ze(.*'
    elseif a:myPart == 'alias'
      let myPattern = '\s\+AS\s\+\zs.*\ze$'
    elseif a:myPart == 'schema'
      let myPattern = 'FROM\s\+\zs[^.]*\ze.'
    elseif a:myPart == 'parameters'
      let myPattern = 'FROM[^(]*(\zs.*\ze)[^)]*$'
    else
      let myPattern = ''
    endif
    return matchstr(matchstr(getline("'{","'}"),"FROM"),myPattern)
endfunction

" function! GetTablename()
"     let pos=getpos('.')
"     return matchstr(matchstr(getline("'{","'}"),"FROM"),'FROM [^.]*\..*\(list\|read\|filter\|get\)_\zs[^(]*\ze(.*')
" endfunction

"run /home/fejleszto/munka/refresh_templates.sh in project root directory
command! BobRefreshTemplates execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:3],"/")."/".';../refresh_templates.sh;cd -' : 'echo "Hol a BOB?"'

"reset database to actual project
command! BobResetDB execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:3],"/")."/".';sudo ./script/reset_db.sh;cd -' : 'echo "Hol a BOB?"'
command! BobResetDBtoTest execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:3],"/")."/".';sudo ./script/reset_db.sh teszthez;cd -' : 'echo "Hol a BOB?"'
nnoremap <C-b>r :BobResetDB<CR>
nnoremap <C-b>R :BobResetDBtoTest<CR>

"reinstall modul
command! BobMakeInstall execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:6],"/")."/".';perl Makefile.PL;sudo make install;cd -' : 'echo "Hol a BOB?"'
nnoremap <C-b>i :BobMakeInstall<CR>

"test modul
command! BobTestModule execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:6],"/")."/".';perl Makefile.PL;make test;cd -' : 'echo "Hol a BOB?"'
command! BobTestModuleVerbose execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:6],"/")."/".';perl Makefile.PL;make test TEST_VERBOSE=1;cd -' : 'echo "Hol a BOB?"'
nnoremap <C-b>t :BobTestModule<CR>

"test all modul
command! BobTestAll execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:3],"/")."/".';../test_all.sh;cd -' : 'echo "Hol a BOB?"'
command! BobTestAllWithResetDB execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:3],"/")."/".';sudo ./script/reset_db.sh teszthez;../test_all.sh;cd -' : 'echo "Hol a BOB?"'

"run prove in module root directory to actual testfile
command! BobProve execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:6],"/")."/".';prove -Ilib '.expand("%:p").';cd -' : 'echo "Hol a BOB?"'
command! BobProveVerbose execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd '."/".join(split(expand("%:p"),"/")[0:6],"/")."/".';prove -v -Ilib '.expand("%:p").';cd -' : 'echo "Hol a BOB?"'
nnoremap <C-b>p :BobProve<CR>
nnoremap <C-b>P :BobProveVerbose<CR>

"run sass and rebuild default.theme.css
command! BobCssBuild execute (split(expand("%:p"),"/")[1] == 'fejleszto') ? '!cd ~/munka/bob4/src/scss/;sass -I ../bootstrap/scss/ -I ./bob/ ./default.theme.scss ~/munka/bob4/core/Bob/public/css/default.theme.css --style expanded --sourcemap=auto --cache-location /tmp/;cd -' : 'echo "Hol a BOB?"'
nnoremap <C-b>c :BobCssBuild<CR>
nnoremap <C-b>C :BobCssBuild<CR>

"insert path to sql folder in BOB virtual machines
cnoremap <expr> <C-b>s (getcmdtype() == ':' && split(expand("%:p"),"/")[1] == 'fejleszto') ? "/".join(split(expand("%:p"),"/")[0:3],"/")."/core/**/sql/" : ''
inoremap <expr> <C-b>s (split(expand("%:p"),"/")[1] == 'fejleszto') ? "/".join(split(expand("%:p"),"/")[0:3],"/")."/core/**/sql/" : ''

"insert path to BOB sql folder in BOB virtual machines
cnoremap <expr> <C-b>S (getcmdtype() == ':' && split(expand("%:p"),"/")[1] == 'fejleszto') ? "/home/fejleszto/munka/bob4/core/Bob/sql/" : ''
inoremap <expr> <C-b>S (split(expand("%:p"),"/")[1] == 'fejleszto') ? "/home/fejleszto/munka/bob4/core/Bob/sql/" : ''

"}}}
"{{{ private settings

"protection against typo
command! Q q
command! Wq wq
command! WQ wq

"edit a new todo.txt file, or jump to the window containing it if it already exists
nnoremap <silent> Í :tab drop Dropbox/todo/todo.txt<CR>

"edit a new memo.txt file, or jump to the window containing it if it already exists
nnoremap <silent> í :tab drop temp/memo.vorg<CR>

"private keywords abbreviations
source ~/.vim/abbreviation_private.vim

"use local vimrc if available
if filereadable(expand("\~/.vimrc.local"))
  source \~/.vimrc.local
endif

" Conceal hyperlinks in .md files
autocmd BufNewFile,BufRead,BufEnter *.md syn match Concealed '\](.*)' conceal cchar=]
autocmd BufNewFile,BufRead,BufEnter *.md set conceallevel=1

"}}}
