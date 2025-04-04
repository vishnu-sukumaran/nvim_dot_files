-- local colors = require("tokyonight.colors").setup()
--
-- require("scrollbar").setup({
--     handle = {
--         color = colors.bg_highlight,
--     }
-- })


-- Get the active flavor dynamically
local flavor = vim.g.catppuccin_flavour -- This contains the current Catppuccin flavor (e.g., "mocha", "macchiato", etc.)

-- Load the palette for the current flavor
local colors = require("catppuccin.palettes").get_palette(flavor)


require("scrollbar").setup({
    handle = {
        color = colors.surface2,
    },
    marks= {
        Cursor = {
            color = colors.sky,
        }
    }
})
