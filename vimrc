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

set mouse=a

colorscheme happy_hacking

filetype plugin indent on

" Nerdtree Config
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>

" Open NERDTree on startup if no arg
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Exit Vim if NERDTree is the only open window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Quit after opening a file
let NERDTreeQuitOnOpen = 1

" Nerdtree UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Run codelens action
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map tex to latex for coc-ltex support
let g:tex_flavor = 'latex'

" CtrlP fuzzy search
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Ignore node_modules when searching
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Set CtrlP root directory to startup dir
let g:ctrlp_working_path_mode = ''

