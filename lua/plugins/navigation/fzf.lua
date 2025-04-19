local M = {}

M.plugin_spec = {
    "junegunn/fzf",

    build = function()
        vim.fn['fzf#install']()
    end
}

return M
