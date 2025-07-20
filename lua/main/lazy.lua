-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('lazy').setup({
    -- Packer can manage itself
    { "nvim-treesitter/nvim-treesitter",          branch = 'master', lazy = false, build = ":TSUpdate" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'tpope/vim-fugitive',
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end

    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    -- {
    --     "williamboman/mason.nvim",
    --     "williamboman/mason-lspconfig.nvim",
    --     "neovim/nvim-lspconfig",
    -- },
    'nvim-lualine/lualine.nvim',
    'ThePrimeagen/harpoon',
    {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            }
        end
    },
    -- { "scottmckendry/cyberdream.nvim" },
    ('sainnhe/sonokai'),
    ('tpope/vim-surround'),
    ({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true
                }
            })
        end,
    }),
    'navarasu/onedark.nvim',
    'nvim-tree/nvim-web-devicons',
    ({
        'echasnovski/mini.nvim',
        config = function()
            require('mini.icons').setup()
        end
    }),
    {
        "ravibrock/spellwarn.nvim",
        event = "VeryLazy",
        config = true,
    },
    -- Lazy
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    checker = { enabled = true }
})
-- Setup lazy.nvim
-- require("lazy").setup({
-- spec = {
-- import your plugins
-- { import = "plugins" },
-- },
-- Configure any other settings here. See the documentation for more details.
-- colorscheme that will be used when installing plugins.
-- install = { colorscheme = { "" } },
-- automatically check for plugin updates
-- checker = { enabled = true },
-- })
