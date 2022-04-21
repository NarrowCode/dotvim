call pathogen#infect()
call pathogen#helptags()

syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set cc=100
set cursorline
set showmatch
set termguicolors

colorscheme dracula

filetype plugin indent on

" Nerdtree Config
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>

" Open NERDTree on startup
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only open window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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

" Code completion for coc
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Run codelens action
nmap <leader>cl  <Plug>(coc-codelens-action)
