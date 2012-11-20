"*****************************************************************************"
"** VIM CONFIGURATION ********************************************************"
"**      Ryan Huffman ********************************************************"
"*****************************************************************************"


"*****************************************************************************"
"** VUNDLE SETUP AND LOAD ****************************************************"
"*****************************************************************************"

" Vundle {{{

" Required for vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'godlygeek/csapprox'
Bundle 'flazz/vim-colorschemes'

Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'mattn/zencoding-vim'
Bundle 'xolox/vim-session'
Bundle 'majutsushi/tagbar'
Bundle 'tomtom/tcomment_vim'
Bundle 'vim-scripts/IndexedSearch'
Bundle 'vim-scripts/python.vim'

" Language plugins
Bundle 'fs111/pydoc.vim'
Bundle 'tpope/vim-markdown'
Bundle 'nvie/vim-flake8'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'oscarh/vimerl'

" }}}


"*****************************************************************************"
"** GENERAL ******************************************************************"
"*****************************************************************************"

" Enable folding for vim files {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" General options {{{

set viminfo='10,\"100,:20,%,n~/.viminfo

set hidden

set t_Co=256

filetype plugin indent on
syntax on

" Make quickfix window occupy the full screen width
botright cwindow

" Leave this near the top so that other settings can override colors
colorscheme darkspectrum

set background=dark

" Highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=black guibg=black

" Highlight space at the end of a line
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=black guibg=black
highlight ExtraWhitespace ctermbg=black guibg=black
match ExtraWhitespace /\s\+$/

" Start moving vertically 7 lines away from top or bottom
set so=7

" Show file info in terminal window
set title

set ignorecase
set smartcase

" Display line numbers
set number numberwidth=2
set nowrap

set nolazyredraw

" Incremental search
set incsearch

" Highlight search results
set hlsearch

" Display tab characters
"set list
"set listchars=tab:>.

set autoindent
set smartindent

" Default tabbing is 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Enable mouse
set mouse=a

" Don't wrap lines
set nowrap

" Highlights matching brackets
set showmatch

set foldmethod=syntax

" GUI Options
set guioptions-=m " turn off menu bar
set guioptions-=T " turn off toolbar

highlight Folded ctermbg=black ctermfg=darkred
highlight FoldColumn ctermbg=black ctermfg=darkred

" Go to line that you were last at in the file
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Set Omnicomplete options, namely "longest"
set cot=menuone,longest
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

highlight Pmenu ctermbg=black
highlight Pmenu ctermfg=green
highlight PmenuSel ctermbg=white
highlight PmenuSel ctermfg=black

" Add clipboard support for Mac OS X (shares pasteboard)
set clipboard=unnamed

set laststatus=2

" No antialias in GUI
set noantialias

" Don't move by lines when using word wrapping
noremap j gj
noremap k gk
noremap [Up] gk
noremap [Down] gj

" Save backups in a different directory so they don't clutter my folders :)
set backupdir=~/.vim/backupfiles,~/tmp

" }}}

" Mappings {{{

" Set map leader to ,
let mapleader = ","

" Edit & source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Open/Close NERDTree
nnoremap <leader>to <esc>:NERDTreeFocus<cr>

" Open current file
nnoremap <leader>oo <esc>:exe "!open " . expand('%:p')<cr><cr>

" Open current file, assumes a server is running with the current
" directory as root
nnoremap <leader>ss <esc>:exe "!open http://localhost:8000/" . @%<cr><cr>

" Run make
nnoremap <leader>mk <esc>:make<cr>
nnoremap <leader>mt <esc>:make test<cr>

" Maps cn and cp for moving between errors and warnings
nnoremap cn <esc>:cn<cr>
nnoremap cp <esc>:cp<cr>

" Paste mode
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <leader>p :set invpaste paste?<CR>

" Remove highlight from search
nnoremap <leader>rh <esc>:nohlsearch<cr>

" Remove extraneous whitespace at the end of lines
nnoremap <leader>rw <esc>:%s/\s\+$//g<cr>

set pastetoggle=<F2>
set showmode

" Git Fugitive mappings {{{
nnoremap <leader>gd <esc>:Gdiff<cr>
nnoremap <leader>gs <esc>:Gstatus<cr>
nnoremap <leader>gc <esc>:Gcommit<cr>
nnoremap <leader>gb <esc>:Gblame<cr>
nnoremap <leader>gh <esc>:Gbrowse<cr>
nnoremap <leader>gl <esc>:Glog<cr>

" }}}

" QuickFix {{{

" Automatically open, but do not go to (if there are errors) the quickfix
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Auto-close quickfix window on file close
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" }}}


"*****************************************************************************"
"** LANGUAGE OPTIONS *********************************************************"
"*****************************************************************************"

" SQL {{{
let g:sql_type_default = 'mysql'
" }}}

" Python {{{

" smartindent screws up python indentation for comments
au! FileType python setl nosmartindent
au! FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Run flakes8 on save
autocmd BufWritePost *.py call Flake8()

" Vertical split pydoc windows
let g:pydoc_open_cmd = 'vsplit'

let g:flake8_ignore='W806'

" }}}

" Unit Testing {{{

au FileType python nnoremap <leader>ua <esc>:!nosetests -s -d %:p:.<cr>

" Run phpunit for current file
au FileType php nnoremap <leader>ua <esc>:!phpunit -s %:p:.<cr>

" Run phpunit for function name under cursor
au FileType php nnoremap <leader>uf <esc>:!phpunit --filter <cword> %:p:.<cr>

" }}}

" Binary {{{

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" }}}


"*****************************************************************************"
"** PLUGIN OPTIONS ***********************************************************"
"*****************************************************************************"

" Ctrl-P {{{

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.tar*
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_use_caching = 1


" }}}

" Tagbar {{{

let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_left = 0
let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions',
        \ 'f:functions',
        \ 'j:javascript functions:1'
    \ ]
  \ }

nnoremap <leader>tb <esc>:TagbarOpen j<cr>
nnoremap <leader>tc <esc>:TagbarClose<cr>

" }}}

let g:SuperTabDefaultCompletionType = "context"
