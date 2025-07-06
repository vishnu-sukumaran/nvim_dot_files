local M = {}
-- Gives indentation lines

local plugin_enabled = false



M.set_ibl = function(enable)
    if enable then
        require('ibl').setup({})
        plugin_enabled = true
    else
        require('ibl').setup({ enabled = false })
        plugin_enabled = false
    end
end



local toggle_ibl = function()
    M.set_ibl(not plugin_enabled)
end



M.plugin_spec = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config

    config = function()
        require('ibl').setup({})
        plugin_enabled = true
        vim.api.nvim_create_user_command('ToggleIBL', toggle_ibl, { desc = "Toggle indentation line" })
    end
}


return M
