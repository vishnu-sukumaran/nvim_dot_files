local M = {}
-- For easily jumping around jumplist

M.plugin_spec = {
    "cbochs/portal.nvim",
    -- Optional dependencies
    dependencies = {
        "cbochs/grapple.nvim",
        "ThePrimeagen/harpoon",
    },

    config = function()
        vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
        vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
    end
}

return M
