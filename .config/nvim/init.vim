" Consider running:
" :autocmd BufWritePost <buffer> source $MYVIMRC

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
set listchars=tab:▸\ ,trail:·
set list
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
Plug 'tanvirtin/monokai.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" monokai
syntax on
colorscheme monokai_black

" move lines
nnoremap <A-down> :m .+1<CR>==
nnoremap ∆        :m .+1<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap ∆        <Esc>:m .+1<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap ∆        :m '>+1<CR>gv=gv
nnoremap <A-up>   :m .-2<CR>==
nnoremap ˚        :m .-2<CR>==
inoremap <A-up>   <Esc>:m .-2<CR>==gi
inoremap ˚        <Esc>:m .-2<CR>==gi
vnoremap <A-up>   :m '<-2<CR>gv=gv
vnoremap ˚        :m '<-2<CR>gv=gv

" indent/dedent
nnoremap <A-left>  <lt><lt>
nnoremap ˙         <lt><lt>
inoremap <A-left>  <C-d>
inoremap ˙         <C-d>
vnoremap <A-left>  <gv
vnoremap ˙         <gv
nnoremap <A-right> >>
nnoremap ¬         >>
inoremap <A-right> <C-t>
inoremap ¬         <C-t>
vnoremap <A-right> >gv
vnoremap ¬         >gv

" esc terminal without messing up fzf
au TermOpen * tnoremap <buffer> <leader><Esc> <c-\><c-n>
" au FileType fzf tunmap <buffer> <Esc>

nnoremap <leader>f :Files<CR>

" command hjkl to move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Control-i inserts one char
nnoremap <C-i> i_<Esc>r

:command JSONFormat %!node -p "JSON.stringify(JSON.parse(require('fs').readFileSync('%','utf8')),null,2)"
