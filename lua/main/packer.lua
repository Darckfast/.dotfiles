local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('tpope/vim-fugitive')
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end

    }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run =
        'make'
    }
    use('nvim-lualine/lualine.nvim')
    use('ThePrimeagen/harpoon')
    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            }
        end
    }
    use('sainnhe/sonokai')
    use('tpope/vim-surround')
    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true
                }
            })
        end,
    })
    use 'nvim-tree/nvim-web-devicons'
    use({
        'echasnovski/mini.nvim',
        config = function()
            require('mini.icons').setup()
        end
    })
    -- Must be at the end
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
