require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'ts_ls',
        'svelte',
        'tailwindcss',
        'eslint',
        'lua_ls',
        'html',
        'eslint',
        'cssls',
        'tailwindcss',
        'svelte',
        'gopls'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

local lspconfig = require("lspconfig")
lspconfig.sources = {
    organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
    }
}
lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<C-Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping.complete()
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.supports_method('textDocument/rename') then
            -- Create a keymap for vim.lsp.buf.rename()
        end
        if client.supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation
        end
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})
