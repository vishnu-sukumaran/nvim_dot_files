local M = {}
-- Gives a scrollbar at the right side

local user_theme = require("user_config").theme

-- Customizes the scrollbar colors according to theme
local function get_scrollbar_opts()
    local handle_color = nil
    local cursor_color  = nil

    -- Takes the handle colour and cursor color from the catppuccin theme.
    if user_theme.name == "catppuccin" then
        -- Get the active flavor dynamically
        -- local flavor = vim.g.catppuccin_flavour -- This contains the current Catppuccin flavor (e.g., "mocha", "macchiato", etc.)
        local flavour = user_theme.config.flavour

        -- Load the palette for the current flavour
        local pcall_success, palette = pcall(require, "catppuccin.palettes") -- catches error instead of crashing
        if pcall_success then
            local colors = palette.get_palette(flavour)
            handle_color = colors.surface2
            cursor_color = colors.sky
        end
    end

    -- Prepare the scrollbar option tables from the above colors
    local setup_arg = nil
    if handle_color and cursor_color then
        setup_arg = {
            handle = {
                color = handle_color,
            },

            marks= {
                Cursor = {
                    color = cursor_color,
                }
            }
        }
    end

    return setup_arg
end


M.plugin_spec = {
    "petertriho/nvim-scrollbar",

    config = function()
        local opts = get_scrollbar_opts() or {}
        require("scrollbar").setup(opts)
    end
}

return M
