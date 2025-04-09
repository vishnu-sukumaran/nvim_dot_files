local M = {}
-- local colors = require("tokyonight.colors").setup()
--
-- require("scrollbar").setup({
--     handle = {
--         color = colors.bg_highlight,
--     }
-- })


function M.setup(theme)
    local handle_color = nil
    local cursor_color  = nil

    if theme.name == "catppuccin" then
        -- Get the active flavor dynamically
        -- local flavor = vim.g.catppuccin_flavour -- This contains the current Catppuccin flavor (e.g., "mocha", "macchiato", etc.)
        local flavor = theme.config.flavour

        -- Load the palette for the current flavor
        local colors = require("catppuccin.palettes").get_palette(flavor)
        handle_color = colors.surface2
        cursor_color = colors.sky
    end

    local setup_arg = nil
    if handle_color and cursor_color then
        setup_arg = {}

        setup_arg.handle = {
            color = handle_color,
        }

        setup_arg.marks= {
            Cursor = {
                color = cursor_color,
            }
        }
    end

    require("scrollbar").setup(setup_arg)
end

return M
