" bug with using vim on WSL causes vim to be opened in replace mode
set t_u7=
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

call plug#begin()

" Navigation
Plug 'dbakker/vim-projectroot'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'

" Editor
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }

call plug#end()

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <silent> <leader><space> :NERDTreeToggle<Enter>
nnoremap <silent> <leader>n :silent! NERDTreeFind<CR>:NERDTreeFocus<CR>
nnoremap <silent> <Leader>f :Files<Enter>
nnoremap <silent> <Leader>b :Buffers<Enter>
nnoremap <silent> <Leader>t :BLine<Enter>


" let g:rooter_patterns = ['.git', 'Makefile']
let g:rooter_patterns = ['>~']

nnoremap <silent> <leader>yy :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yd :YcmDiags<CR>
nnoremap <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <Leader>y: :YcmCompleter<Space>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

let g:airline#extensions#tabline#enabled = 1

" remap <esc> key
inoremap ,. <esc>
noremap ,. <esc>
" remap ;
nnoremap ; :
vnoremap ; :
" update vimrc on-the-fly 
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" next/prev tab
nnoremap H gT
nnoremap T gt
" yank to end of line
nnoremap Y y$
" keep cursor centered for n, N, J
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" undo up to period or comma
inoremap . .<c-g>u
inoremap , ,<c-g>u
" add relative jupms to jump list
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
" add resizing of horizontal splits
nnoremap _ :res -3<cr>
nnoremap + :res +3<cr>
" swap `l` and `t` in normal mode
" move commonly used keys away from pinky finger :')
nnoremap t l
nnoremap l t
nnoremap L T
vnoremap T L
vnoremap L T
" make switching panes consistent with `t` <-> `l` swap
nnoremap <c-w>t <c-w>l
" auto bracket completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
" auto paren completion
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()
inoremap AA <esc>A


" quick-fix and local list
nnoremap <c-q> :copen<cr>
nnoremap <c-j> :cnext<cr>
nnoremap <c-k> :cprev<cr>
nnoremap <leader>q :lopen<cr>
nnoremap <leader>j :lnext<cr>
nnoremap <leader>k :lprev<cr>
" close current tab
nnoremap <leader>x :tabclose<cr>
" save file
" also to avoid using pinky finger :')
nnoremap <leader>w :w<cr>

noremap <silent> <Leader>, :call ToggleWrap()<CR>
function WrapOn()
  setlocal wrap linebreak
  set virtualedit=
  setlocal display+=lastline
  noremap  <buffer> <silent> <Up>   g<Up>
  noremap  <buffer> <silent> <Down> g<Down>
  noremap  <buffer> <silent> <Home> g<Home>
  noremap  <buffer> <silent> <End>  g<End>
  inoremap <buffer> <silent> <Up>   <C-o>gk
  inoremap <buffer> <silent> <Down> <C-o>gj
  inoremap <buffer> <silent> <Home> <C-o>g<Home>
  inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction
function WrapOff()
  setlocal nowrap
  set virtualedit=
  silent! nunmap <buffer> <Up>
  silent! nunmap <buffer> <Down>
  silent! nunmap <buffer> <Home>
  silent! nunmap <buffer> <End>
  silent! iunmap <buffer> <Up>
  silent! iunmap <buffer> <Down>
  silent! iunmap <buffer> <Home>
  silent! iunmap <buffer> <End>
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

" <Leader>' -- Cycle through relativenumber + number, number (only), and no
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
set nohlsearch
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
set scrolloff=8
" Open all folds upon buffer read
au BufRead * normal zR
" Allow for mouse support, such as scrolling / clicking on tabs
" using 'n' insted of 'a' bc of copy/paste issue 
set mouse=n
" set mouse=a

syntax on
let &colorcolumn=81
colorscheme PaperColor
set background=dark
