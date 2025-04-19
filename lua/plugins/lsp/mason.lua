local M = {}
-- LSP server installation manager.

M.plugin_spec = {
    "williamboman/mason.nvim",
    config = true, -- This is the same: config = function() require("mason").setup() end
}

return M
