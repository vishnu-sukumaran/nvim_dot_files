local M = {}

function M.setup(theme_config)
    local lookup = {
        mocha = function()
            require("catppuccin").setup {
                flavour = "mocha"
            }
        end,

        latte = function()
            require("catppuccin").setup {
                flavour = "latte"
            }
        end,
    }

    lookup[theme_config.flavour]()
    vim.api.nvim_command("colorscheme catppuccin-"..theme_config.colorscheme)
end

return M 
