local M = {}
-- Enclose a text object with a pattern. (Eg. enclose in "", {}, (), ...)

M.plugin_spec = {
    "kylechui/nvim-surround",

    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
}

return M
