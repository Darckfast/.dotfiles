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
                    vim.lsp.buf.format({ bufnr = args.buf })
                    -- vim.lsp.buf.format()
                end,
            })
        end
    end,
})
