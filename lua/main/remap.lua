vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>vv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>vv", '<cmd>Oil<CR>')

vim.keymap.set("v", "<C-Down>", ":m  '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m  '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("i", '"', '""<Left>')
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", '(', '()<Left>')
vim.keymap.set("i", '[', '[]<Left>')
vim.keymap.set("i", '{', '{}<Left>')
vim.keymap.set("i", '{<CR>', '{<CR>}<Esc>O')

-- vim.keymap.set("n", '<leader>u', ':buffer #<CR>')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader-l>', "<cmd>lua require('jdtls').organize_imports()<cr>")

vim.api.nvim_create_user_command('W', 'w', {})
