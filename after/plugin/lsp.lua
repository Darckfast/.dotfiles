local lsp = require('lsp-zero')


lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr }
end)

-- lsp.sve
-- require('')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'lua_ls',
        'gopls'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

-- lsp.setup()

lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local lspconfig = require("lspconfig")
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


lsp.format_on_save({
    format_opts = {
        async = true,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['tsserver'] = { 'typescript', 'typescriptreact' },
        ['svelte'] = { 'svelte' }
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tf", "*.go", "*.js", "*.ts", "*.svelte" },
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = true })
    end
})
