local M = {}

--------------------------------------------------------------------------------
--                          User configuration
--------------------------------------------------------------------------------
-- Possible values for theme = "mocha", "latte"
local theme = "mocha"
--------------------------------------------------------------------------------



local function get_theme(theme_name)
    local theme_info = {}

    -- Default theme is mocha
    theme_name = theme_name or "mocha"

    local catppuccin_variants = { mocha = true, latte = true }
    if catppuccin_variants[theme_name] then
        theme_info.name = "catppuccin"
        theme_info.config = { flavour = theme_name, colorscheme = theme_name }
    end

    return theme_info
end

M.theme = get_theme(theme)

return M
