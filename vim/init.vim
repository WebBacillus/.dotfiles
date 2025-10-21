vim.wo.relativenumber = true
vim.wo.number = true
" vim.g.clipboard = {
"  name = 'win32yank',
"  copy = {
"    ["+"] = 'win32yank.exe -i --crlf',
"    ["*"] = 'win32yank.exe -i --crlf',
"  },
"  paste = {
"    ["+"] = 'win32yank.exe -o --lf',
"    ["*"] = 'win32yank.exe -o --lf',
"  },
"  cache_enabled = 0,
"}
vim.opt.clipboard="unnamedplus"
vim.g.mapleader=" "
vim.g.maplocalleader="\\"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.termguicolors = true
