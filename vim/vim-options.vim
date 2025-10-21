nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Set relative line numbers
set relativenumber

" Set absolute line numbers
set number

" Configure clipboard using win32yank
" let g:clipboard = {
"  'name': 'win32yank',
"  'copy': {
"    '+': 'win32yank.exe -i --crlf',
"    '*': 'win32yank.exe -i --crlf',
"  },
"  'paste': {
"    '+': 'win32yank.exe -o --lf',
"    '*': 'win32yank.exe -o --lf',
"  },
"  'cache_enabled': 0,
" }

" Enable unnamedplus clipboard integration
set clipboard=unnamedplus

" Set mapleader to space
let mapleader = " "

" Set maplocalleader to backslash
let maplocalleader = "\\"

" Set expandtab (use spaces instead of tabs)
set expandtab

" Set tabstop to 2 spaces
set tabstop=2

" Set softtabstop to 2 spaces
set softtabstop=2

" Set shiftwidth to 2 spaces
set shiftwidth=2

" Enable termguicolors
set termguicolors

