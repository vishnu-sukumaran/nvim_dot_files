local M = {}
-- Catppuccin theme

local check_catppuccin_enabled = function()
    local user_theme = require("user_config").theme

    if user_theme.name == "catppuccin" then
        return true
    else
        return false
    end
end

M.plugin_spec = {
    "catppuccin/nvim",
    as = "catppuccin",
    enabled = check_catppuccin_enabled(),

    config = function()
        local catppuccin_variant = require("user_config").theme.config
        require("catppuccin").setup { flavour = catppuccin_variant.flavour }

        vim.api.nvim_command("colorscheme catppuccin-" .. catppuccin_variant.colorscheme)
    end
}

return M
