local builtin = require('telescope.builtin')
local tel_theme = require('telescope.themes')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.buffers)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(tel_theme.get_dropdown {
        windblen = 10,
        previewer = false,
    })
end)

local telescope = require("telescope")
--
telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".git", "public" }
    },
    extensions = {
        fzf = {}
    }
})

telescope.load_extension('fzf')

