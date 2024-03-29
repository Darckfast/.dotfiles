local lsp = require('lsp-zero').preset({})


lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    -- lsp.buffer_autoformat()

    local opts = { buffer = bufnr }

    -- vim.keymap.set({ 'n', 'x' }, 'gq', function()
    -- vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    -- end, opts)

    -- vim.keymap.set('n', '<C-g>', vim.lsp.buf.signature_help())
end)


lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'lua_ls',
    'gopls'
})

lsp.setup()

-- Fix Undefined global 'vim'
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

-- You need to setup `cmp` after lsp-zero
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

-- vim.diagnostic.config({
-- virtual_text = true
-- })

lsp.format_on_save({
    format_opts = {
        async = true,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['tsserver'] = { 'typescript' },
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tf", "*.go", "*.js", "*.ts", "*.svelte" },
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
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
