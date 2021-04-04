
let g:mapleader="\<Space>"

call plug#begin()

" Navigation
Plug 'dbakker/vim-projectroot'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>n :silent! NERDTreeFind<CR>:NERDTreeFocus<CR>


set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=2
set smartindent
set number
set hlsearch
set incsearch
set hidden
set cursorline
set splitright
set splitbelow
set nobackup
set noswapfile
set foldmethod=syntax
set foldlevelstart=99
" Allow for mouse support, such as scrolling / clicking on tabs
set mouse=a

syntax on
let &colorcolumn=81
if has('gui_running')
    colo monokai-phoenix
else
    colo default
endif
