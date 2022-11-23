" use :PlugInstall to install dependencies
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'catppuccin/nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tribela/vim-transparent'
Plug 'goolord/alpha-nvim'
call plug#end()

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

" Remap space to leader
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <Leader>w :CocCommand prettier.formatFile<cr>:w<cr>
nnoremap <Leader>q :q<cr>
nnoremap <C-p> <cmd>Telescope find_files hidden=true<cr>
nnoremap <Leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep hidden=true<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags hidden=true<cr>
nnoremap <Leader>1 1gt
nnoremap <Leader>2 1gt
nnoremap <Leader>3 1gt
nnoremap <Leader>4 1gt
nnoremap <Leader>5 1gt
nnoremap <Leader>6 1gt
nnoremap <Leader>t :tablast<cr>
nnoremap <Leader>T :tabprevious<cr>
nnoremap <Leader>p "0p
nnoremap <Leader>y "0y
nnoremap <Leader>< :vertical resize -5<cr>
nnoremap <Leader>> :vertical resize +5<cr>
nnoremap <Leader>+ :resize +5<cr>
nnoremap <Leader>- :resize -5<cr>

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument<cr>
nnoremap <Leader>f :CocCommand prettier.formatFile<cr>

" Clipboard
vnoremap <C-x> "+x
vnoremap <C-c> "+y
vnoremap <C-v> "+v

set mouse=a

" colorscheme happy_hacking
" let g:catppuccin_flavour = "dusk" " latte, frappe, macchiato, mocha, dusk

let g:material_theme_style = 'default'
let g:material_terminal_italics = 1
colorscheme material

" Custom override for material darker
" let s:line_highlight = { 'gui': '#384c54', 'cterm': 68 }
hi CursorLine guibg=#0d0e13 ctermbg=68
hi CursorLineNr guifg=#8d9cd2 ctermfg=244

filetype plugin indent on

" Nerdtree Config
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>

" Open NERDTree on startup if no arg
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
  inoremap <silent><expr> <c-g> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Coc gotos 
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> gh :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('gh', 'in')
  endif
endfunction


nmap <silent> gp :CocCommand markdown-preview-enhanced.openPreview<CR>
nmap <silent> gs :CocCommand markdown-preview-enhanced.syncPreview<CR>

" 300ms update time for coc
set updatetime=300

" Renaming
nmap <leader>rn <Plug>(coc-rename)

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Coc-Highlight enable highlighting on current symbol
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Jump to next problem
nnoremap <silent><leader>p :call CocAction('diagnosticNext')<CR>
nnoremap <silent><leader>P :call CocAction('diagnosticPrevious')<CR>

" Run codelens action
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map tex to latex for coc-ltex support
let g:tex_flavor = 'latex'

" Ignore node_modules when searching
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Set CtrlP root directory to startup dir
let g:ctrlp_working_path_mode = ''

" More than 10 results in the list
let g:ctrlp_match_window = 'results:100'

lua << EOF
  require("alpha-setup")
EOF
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      ".git/", "**/.yarn/*", "dist", "yarn.lock", "*.pdf"
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--ignore-file',
      '.gitignore'
    },
  },
  color_devicons = true,
}
EOF

"lua << EOF
"require'alpha'.setup(require 'alpha.themes.startify'.config)
"EOF
