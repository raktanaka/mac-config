" Author:        Josh Davis
" Description:   This is the personal .vimrc file of Josh Davis. I've tried to
"                document every option and item. Feel free to use it to learn
"                more about configuring Vim.
"
"                Also, I encourage you to pick out the parts that you use and
"                understand rather than blindly using it.
"
"                You can find me on Github: http://github.com/jdavis Or my
"                personal site: http://joshldavis.com

" **Must be first uncommented line**
set nocompatible
filetype off

set encoding=utf-8
scriptencoding utf-8

"
" Determine what we have
"

let s:OS='linux'

let s:plugins=isdirectory(expand('~/.vim/bundle/vundle', 1))

"
" Setup folder structure
"

if !isdirectory(expand('~/.vim/undo/', 1))
    silent call mkdir(expand('~/.vim/undo', 1), 'p')
endif

if !isdirectory(expand('~/.vim/backup/', 1))
silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif

if !isdirectory(expand('~/.vim/swap/', 1))
    silent call mkdir(expand('~/.vim/swap', 1), 'p')
endif

"
" Custom Functions
"

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<cr>
        normal `z
        retab
    endif
endfunction

nnoremap <space><space> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"
" Global Settings
"

" The default 20 isn't nearly enough
set history=1000

" Show the numbers on the left of the screen
set number

" Show the column/row
set ruler

" Pretty colors are fun, yayyy
syntax on

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

" Ignore case when doing a search as well as highlight it as it is typed
set ignorecase smartcase
set hlsearch
set incsearch

" Don't show the startup message
" set shortmess=I

" Show the current command at the bottom
set showcmd

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use smarter defaults
set smartindent
set smarttab

" Use autoindenting
set autoindent

" 4 spaces indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 2 spaces in Lua, Ruby
autocmd FileType lua,ruby set tabstop=2
autocmd FileType lua,ruby set shiftwidth=2

" Spaces, not Tab
set expandtab

" Buffer Settings
set hidden

" Better completion
set completeopt+=longest,menuone,preview

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Use backups
" Source:
"   http://stackoverflow.com/a/15317146
set backup
set writebackup
set backupdir=~/.vim/backup//

" Use a specified swap folder
" Source:
"   http://stackoverflow.com/a/15317146
set directory=~/.vim/swap//

" The comma makes a great leader of men, heh heh
let mapleader = ','
let maplocalleader = '\'

" Show two lines for the status line
set laststatus=2

" Always show the last line
set display+=lastline

" Enhanced mode for command-line completion
set wildmenu

" Automatically re-read the file if it has changed
set autoread

" Fold Settings

" Off on start
set nofoldenable

" Indent seems to work the best
set foldmethod=indent
set foldlevel=20

"
" Global Bindings
"

" Disable ex mode, ick, remap it to Q instead.
"
" Tip:
"   Use command-line-window with q:
"   Use search history with q/
"
" More info:
" http://blog.sanctum.geek.nz/vim-command-window/
nmap Q q

" Control enhancements in insert mode
"imap <C-F> <right>
"imap <C-B> <left>
"imap <M-BS> <esc>vBc
"imap <C-P> <up>
"imap <C-N> <down>

" Buffer - bufkill
map <C-c> :BD<CR>
map <C-t> :BD<CR>

" Esc is too far
nmap <C-Space> <Esc>
imap <C-Space> <Esc>
vmap <C-Space> <Esc>
nmap <C-CR> i
nnoremap <S-CR> a

" When pushing j/k on a line that is wrapped, it navigates to the same line,
" just to the expected location rather than to the next line
nnoremap j gj
nnoremap k gk
" WASD FTW
nmap w k
nmap a h
nmap s j
nmap d l
vmap w k
vmap a h
vmap s j
vmap d l

" Walking around
nmap <C-up> 20k10j
nmap <C-down> 20j10k
nmap <C-left> ^
nmap <C-right> w
nmap <S-left> 0
nmap <S-right> $
nmap <S-up> gg
nmap <S-down> G
"
imap <C-up> <Esc>20k10ji
imap <C-down> <Esc>20j10ki
imap <C-left> <Esc>^i
imap <C-right> <Esc>wi<right>
imap <S-right> <Esc>$i<right>
imap <S-left> <Esc>0i
imap <S-up> <Esc>ggi
imap <S-down> <Esc>Gi
"
vmap <C-up> 20k10j
vmap <C-down> 20j10k
vmap <S-left> 0
vmap <C-right> w
vmap <S-right> $
vmap <S-up> gg
vmap <S-down> G

" Faster erasing
imap <C-BS> <Esc>vbc
imap <S-BS> <Esc>v0c
imap <C-Del> <Esc>vec
imap <S-Del> <Esc>v$c

" Non quitting analog of ZZ
nmap zz :w<cr>

" Map CTRL+TAB
nnoremap <C-Tab> :bn<CR>
inoremap <C-Tab> <Esc>:bn<CR>

" Map CTRL+Z
nmap <C-z> u
imap <C-z> <Esc>ui

set autochdir
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>

" Select all text
"nmap <C-a> ggVG
"vmap <C-a> ggVG
" Map Ctrl+C to copy in Visual mode
vmap <C-c> yi
" Map Ctrl+Shift+C to clipboard copy in Visual mode
vmap <C-S-c> "+y
" Map Ctrl+V to paste in Insert mode
imap <C-v> <Esc>pi
" Map Ctrl+Shift+V to clipboard paste in Insert mode
imap <C-S-v> <Esc>"+p

" GVim Settings
if has('gui_running')
"     " Who uses a GUI in GVim anyways? Let's be serious.
     set guioptions=egirLt
" 
"     " Ensure that clipboard isn't clobbered when yanking
     set guioptions-=a
endif

" Ignore some defaults
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Fold Keybindings
"nnoremap <space> za

"
" Custom Settings
"

" Set on textwidth when in markdown files
autocmd FileType markdown set textwidth=80

" Smarter completion in C
autocmd FileType c set omnifunc=ccomplete#Complete

" Required by Vundle (added uptop)
" filetype off

" Vundle is the new god among plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Vundle Bundles + Settings
"

Plugin 'VundleVim/Vundle.vim'

" Statusline
Plugin 'itchyny/lightline.vim'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" Buffers
Plugin 'ap/vim-buftabline'
Plugin 'qpkorr/vim-bufkill'
" Plugin 'bling/vim-bufferline'
" Plugin 'zefei/vim-wintabs'

" Git/GitHub plugins
Plugin 'tpope/vim-fugitive'

" Startify
" Plugin 'mhinz/vim-startify'

" File overview
" Plugin 'Shougo/unite.vim'

" Navigation
" Plugin 'kien/ctrlp.vim'

" Appearance
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'

" Syntax
" Plugin 'tpope/vim-markdown'

" Utilities
" Plugin 'Lokaltog/vim-easymotion'

" Vim improvements
" Plugin 'embear/vim-localvimrc'

" Autocompletion
" Plugin 'tpope/vim-surround'

" Snippets
" Plugin 'honza/vim-snippets'

" NERDTree
Plugin 'scrooloose/nerdtree'

" NERDTreeTabs
Plugin 'jistr/vim-nerdtree-tabs'

" Session Manager
" Plugin 'thaerkh/vim-workspace'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'

" Themes
Plugin 'w0ng/vim-hybrid'
Plugin 'chriskempson/base16-vim'
" Plugin 'chriskempson/tomorrow-theme'
" Plugin 'notpratheek/vim-luna'
" Plugin 'freeo/vim-kalisi'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'NLKNguyen/papercolor-theme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" let g:color_schemes = ['vim-kalisi', 'vim-colorschemes']

" Wintabs
" let g:wintabs_autoclose = 0
" let g:wintabs_autoclose_vim = 0
" let g:wintabs_ui_show_vimtab_name = 2

" buftabline
let g:buftabline_show = 2
let g:buftabline_numbers = 2
let g:buftabline_separators = 0

" bufferline
" let g:bufferline_echo = 0
" let g:bufferline_active_buffer_left = '[ '
" let g:bufferline_active_buffer_right = ' ]'

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

" let g:lightline = {
" 	\ 'enable': {
" 		\ 'statusline': 1,
" 		\ 'tabline': 1
" 	\ },
" 	\ 'colorscheme': 'wombat',
" 	\ 'active': {
" 	\   'left': [ [ 'mode', 'paste' ],
" 	\             [ 'fugitive', 'readonly', 'filename', 'modified' ],
" 	\             [ 'bufferline' ] ]
" 	\ },
" 	\ 'component': {
" 	\   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
" 	\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
" 	\   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
" 	\ },
" 	\ 'component_visible_condition': {
" 	\   'readonly': '(&filetype!="help"&& &readonly)',
" 	\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"  	\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
" 	\ },
" 	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
" 	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
" 	\ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '"\ue0a0" '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" indentLine'
let g:indentLine_char = '│'

" vim-indent-guides
" set ts=4 sw=4 et
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1

" Autocomplete
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '/home/raktanaka/.ycm_extra_conf.py'

" NERDTree
autocmd VimEnter * NERDTree ~/
" let NERDTreeShowBookmarks=1

" Session Manager
"let g:workspace_autosave_always = 1
let g:session_autosave = 'no'
"let g:session_autoload = 1
"let g:session_default_to_last = 1

" Vundle mapping
" nmap <leader>vl :BundleList<cr>
" nmap <leader>vi :BundleInstall<cr>

" Airline options
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = 'kalisi'

" Whitespace settings
" Show trailing whitespace and tabs obnoxiously
set list listchars=tab:\|\ ,eol:¬
set list

" fun! ToggleWhitespace()
"     ToggleBadWhitespace
"     if &list
"         set nolist
"     else
"         set list listchars=tab:▸\ ,trail:_ ,eol:¬
"         set list
"     endif
" endfun


" Load plugins and indent for the filtype
" **Must be last for Vundle**
filetype plugin indent on

"
" Misc/Non Plugin Settings
"


" Let's make it pretty
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm

set t_Co=256
set background=dark
colorscheme hybrid
" colorscheme base16-eighties
" Tomorrow-Night-Eighties
" antares
" base16-default
" base16-eighties
" base16-google
" base16-tomorrow

" Must be loaded after all color scheme plugins
" if HasColorScheme('kalisi') && s:plugins
"     colorscheme kalisi
" endif

if has('gui_running')
	set guifont=Source\ Code\ Pro\ Regular\ 10
	set lines=50 columns=120
endif

" NERDTree size
let g:NERDTreeWinSize=30

" column limit
set textwidth=80
set colorcolumn=+1

set cursorline
set noshowmode

let NERDTreeHijackNetrw=0

" text expansion \\\ to \*_
iabbrev /// /* 
" text expansion /// to */
iabbrev \\\ */
