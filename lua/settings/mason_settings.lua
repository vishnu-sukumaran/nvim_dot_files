require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "lua_ls" --[[ , "autotools_ls", "markdown_oxide" ]] }
})


local on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementaton, {})
    vim.keymap.set('n', '<leader>gr', require('telesope.builtin').lsp_references, {})
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
end


require("lspconfig").clangd.setup {}
require("lspconfig").lua_ls.setup {}
-- require("lspconfig").autotools_ls.setup {}
-- require("lspconfig").markdown_oxide.setup {}
