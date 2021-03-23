set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=2
set smartindent
set nu
set hlsearch
set incsearch
set hidden
set cursorline
set splitright
set splitbelow
set nobackup
set noswapfile
" Allow for mouse support, such as scrolling / clicking on tabs
set mouse=a

syntax on
let &colorcolumn=81
if has('gui_running')
    colo monokai-phoenix
else
    colo default
endif
