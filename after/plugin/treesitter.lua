require 'nvim-treesitter'.install{ 'go', 'javascript', 'svelte', 'lua', 'toml', 'gotmpl'}

require("telescope").setup({
  defaults = {
    preview = {
      treesitter = false,
    },
  },
})

vim.api.nvim_create_autocmd('FileType', { 
    callback = function() 
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start) 
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
    end, 
})
