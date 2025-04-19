local M = {}
-- Gives a directory tree at the left side

M.plugin_spec = {
    "nvim-tree/nvim-tree.lua",

    -- disable netrw at the very start of the init.lua(strongly advised)
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
            update_focused_file = {
                enable = true,
            }
        })

        vim.keymap.set("n", "<Leader>T", ":NvimTreeFindFileToggle<CR>")
    end
}

return M
