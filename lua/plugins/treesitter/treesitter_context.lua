local M = {}
-- Gives context of function, if block, etc... at the top of the screen.

M.plugin_spec = {
    "nvim-treesitter/nvim-treesitter-context",

    config = function()
        require("treesitter-context").setup {
            max_lines = 3,
            trim_scope = 'outer',
        }

        vim.keymap.set("n", "<Leader>t", ":TSContextToggle<CR>", { desc = "Toggle context", noremap = true })
    end
}

return M
