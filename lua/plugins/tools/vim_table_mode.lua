local M = {}
-- Easily manage text based tables.

local vim_table_mode_config = function()
    vim.cmd([[let b:table_mode_corner='+']])
    vim.cmd([[let b:table_mode_corner_corner='+']])
    vim.cmd([[let b:table_mode_fillchar='=']])
end

M.plugin_spec = {
    "dhruvasagar/vim-table-mode",
    enabled = false,
    config = vim_table_mode_config,
}

return M
