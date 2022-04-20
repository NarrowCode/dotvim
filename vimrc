call pathogen#infect()
call pathogen#helptags()

syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set cc=80
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

autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only open window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

