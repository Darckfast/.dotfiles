local commnet = require('Comment')
local api = require('Comment.api')
vim.keymap.set('n', '<C-e>', api.toggle.linewise.current)
vim.keymap.set('v', '<C-r>', api.toggle.blockwise.current)

local esc = '<Esc>'

-- Toggle selection (linewise)
vim.keymap.set('x', '<leader>c', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
end)

--[[ -c> Toggle selection (blockwise) ]]
vim.keymap.set('x', '<leader>b', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.blockwise(vim.fn.visualmode())
end)
