local M = {}
-- Code outline window which use lsp if available or else falls back to tree-sitter

M.plugin_spec = {
    'stevearc/aerial.nvim',

    opts = {
        -- Optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "<leader>{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,

        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        manage_folds = true,
    },

    --Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },

    config = function(_,opts)
        require("aerial").setup(opts)
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end
}

return M
