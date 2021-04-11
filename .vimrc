
" bug with using vim on WSL causes vim to be opened in replace mode
set t_u7=
let g:mapleader="\<Space>"

call plug#begin()

" Navigation
Plug 'dbakker/vim-projectroot'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }

" colorschemes
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <silent> <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>n :silent! NERDTreeFind<CR>:NERDTreeFocus<CR>

nnoremap <silent> <Leader>yy :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yd :YcmDiags<CR>
nnoremap <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <Leader>y: :YcmCompleter<Space>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function WrapOn()
  setlocal wrap linebreak
  " set virtualedit=
  " setlocal display+=lastline
  " noremap  <buffer> <silent> <Up>   g<Up>
  " noremap  <buffer> <silent> <Down> g<Down>
  " noremap  <buffer> <silent> <Home> g<Home>
  " noremap  <buffer> <silent> <End>  g<End>
  " inoremap <buffer> <silent> <Up>   <C-o>gk
  " inoremap <buffer> <silent> <Down> <C-o>gj
  " inoremap <buffer> <silent> <Home> <C-o>g<Home>
  " inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction
function WrapOff()
  setlocal nowrap
  " set virtualedit=
  " silent! nunmap <buffer> <Up>
  " silent! nunmap <buffer> <Down>
  " silent! nunmap <buffer> <Home>
  " silent! nunmap <buffer> <End>
  " silent! iunmap <buffer> <Up>
  " silent! iunmap <buffer> <Down>
  " silent! iunmap <buffer> <Home>
  " silent! iunmap <buffer> <End>
endfunction
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call WrapOff()
  else
    echo "Wrap ON"
    call WrapOn()
  endif
endfunction
call WrapOn()

" <Leader>r -- Cycle through relativenumber + number, number (only), and no
" numbering (mnemonic: relative).
nnoremap <silent> <Leader>' :call Cycle_numbering()<CR>
" Cycle through relativenumber + number, number (only), and no numbering.
function! Cycle_numbering() abort
if exists('+relativenumber')
execute {
	  \ '00': 'set relativenumber   | set number',
	  \ '01': 'set norelativenumber | set number',
	  \ '10': 'set norelativenumber | set nonumber',
	  \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
else
" No relative numbering, just toggle numbers on and off.
set number!<CR>
endif
endfunction

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=2
set smartindent
set hlsearch
set incsearch
set hidden
set number
set relativenumber
set cursorline
set splitright
set splitbelow
set nobackup
set noswapfile
set foldmethod=syntax
" Open all folds upon buffer read
au BufRead * normal zR
" Allow for mouse support, such as scrolling / clicking on tabs
set mouse=a

syntax on
let &colorcolumn=81
colorscheme PaperColor
set background=dark
