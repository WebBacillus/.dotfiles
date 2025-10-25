-- vim.keymap.set('n', 'hn', require('harpoon.ui').nav_next)
-- vim.keymap.set('n', 'hp', require('harpoon.ui').nav_prev)
-- vim.keymap.set('n', '<C-1>', require('harpoon.ui').nav_file(1))
-- vim.keymap.set('n', '<C-2>', require('harpoon.ui').nav_file(2))
vim.keymap.set('n', '<C-e>', ':Telescope harpoon marks<CR>', {})
vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file)
vim.keymap.set('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dr', ":lua require'dap'.continue()<CR>")

return {}
