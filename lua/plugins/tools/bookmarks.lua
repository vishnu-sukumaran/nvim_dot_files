local M = {}
-- Manage bookmarks which lasts after sessions and independent of root directories

M.plugin_spec = {
    "LintaoAmons/bookmarks.nvim",
    -- pin the plugin at specifc version for stability
    -- backup your bookmark sqlite db when there are breaking changes
    -- tag = "v2.3.0",
    dependencies = {
        {"kkharji/sqlite.lua"},
        {"nvim-telescope/telescope.nvim"},
        {"stevearc/dressing.nvim"} -- optional: better UI
    },
    opts = {},
    config = function(_, opts)
        require("bookmarks").setup(opts)
        vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
        vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
        vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
        vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark." })
    end
}

return M
