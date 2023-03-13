" Standard .vimrc for anything without nvim installed.

syntax on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set cursorline
set showmatch

if (has('termguicolors'))
  set termguicolors
endif

set scrolloff=10

" Space for the win
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>

" No telescope, at least let me explore the files manually then
nnoremap <C-p> :Ex<cr>
nnoremap <Leader>p "0p
nnoremap <Leader>y "0y
nnoremap <Leader>< :vertical resize -5<cr>
nnoremap <Leader>> :vertical resize +5<cr>
nnoremap <Leader>+ :resize +5<cr>
nnoremap <Leader>- :resize -5<cr>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

set mouse=a

" Move split panes left / bot / top / right
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L

" Swap between panes left / bot / top / right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move visual buffer around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Always search in the center
nnoremap n nzzzv
nnoremap n Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv

" Paste over something
xnoremap <leader>p "_dP

" System clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+p

" Delete into nothingness
nnoremap <leader>d "_d
vnoremap <leader>d "_d

set updatetime=200

