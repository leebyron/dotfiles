"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
"source ~/.vim/vimrc

set nocompatible
syntax on
set ruler
set mouse=a
set number relativenumber
set termguicolors
set visualbell
set encoding=utf-8
set matchpairs+=<:>
set ttyfast
set autoread
set number
set clipboard=unnamed
set listchars=tab:▸\ ,eol:¬
set smartcase
set showmatch
set wrap
set textwidth=80
set splitbelow
set splitright
set formatoptions=tcroqnl1j
set tabstop=2
set shiftwidth=2
set expandtab
let mapleader = " "

map <leader><space> :let @/=''<cr>" clear search

" fzf
set rtp+=/usr/local/opt/fzf

" resize splits
augroup ReduceNoise
  autocmd!
  " Automatically resize active split to 85 width
  autocmd WinEnter * :call ResizeSplits()
augroup END
function! ResizeSplits()
  set winwidth=88
  wincmd =
endfunction

" toggle line numbers
augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Install Vim Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
" Plug 'tpope/vim-sensible'
" Plug 'junegunn/seoul256.vim'
Plug 'tanvirtin/monokai.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" function! MyHighlights() abort
 " highlight Visual     cterm=NONE ctermbg=76  ctermfg=16  gui=NONE guibg=#5fd700 guifg=#000000
  "highlight StatusLine gui=NONE guibg=#000000
 "  highlight Normal gui=NONE guibg=#000000
  " highlight NonText gui=NONE guibg=#000000
"endfunction

"augroup MyColors
  "autocmd!
  "autocmd ColorScheme monokai call MyHighlights()
"augroup END
syntax on
colorscheme monokai_black

" move lines
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv

" esc terminal without messing up fzf
au TermOpen * tnoremap <buffer> <leader><Esc> <c-\><c-n>
" au FileType fzf tunmap <buffer> <Esc>

nnoremap <leader>f :Files<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Control-i inserts one char
nnoremap <C-i> i_<Esc>r

:command JSONFormat %!node -p "JSON.stringify(JSON.parse(require('fs').readFileSync('%','utf8')),null,2)"
