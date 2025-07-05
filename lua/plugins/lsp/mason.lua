local M = {}
-- LSP server installation manager.

M.plugin_spec = {
    "williamboman/mason.nvim",
    version = "1.11.0",
    config = true, -- This is the same: config = function() require("mason").setup() end
}

return M
