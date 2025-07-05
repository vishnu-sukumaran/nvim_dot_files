local M = {}
-- A binding between the nvim-lspconfig and mason.

local lsp_set_keymapping = function(_, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
end

-- Language server list
local lsp_servers = {
    c = "clangd",
    lua = "lua_ls",
    markdown = "markdown_oxide",
}

local get_lsp_list = function()
    local lsp_list = {}

    for _,server_name in pairs(lsp_servers) do
        table.insert(lsp_list, server_name)
    end

    return lsp_list
end

M.plugin_spec = {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
        ensure_installed = get_lsp_list(),
        handlers = {
            -- Default handler (runs for all LSPs unless overridden)
            function(server_name)
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                require("lspconfig")[server_name].setup {
                    on_attach = lsp_set_keymapping,
                    capabilities = capabilities -- required for autocompletion
                }
            end,
        },
    },
}

return M
