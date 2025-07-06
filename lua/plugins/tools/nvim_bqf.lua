local M = {}
-- Modern quickfix

--[
--  ______ Keybinding ______
-- P - preview on/off
-- >/< - next/previous quickfix list
-- zp - full height / short height toggle
--]



local limit_quickfix_window_height = function(entries)
    vim.api.nvim_create_autocmd('BufWinEnter', {
        callback = function()
            if vim.bo.filetype == 'qf' then
                vim.cmd('resize ' .. entries)
            end
        end,
    })
end



local set_quickfix_toggle_keymap = function()
    vim.keymap.set('n', '<leader>q', function()
        local is_qf_open = false

        -- Check if any window is a quickfix window
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            if vim.bo[bufnr].filetype == 'qf' then
                is_qf_open = true
                break
            end
        end

        if is_qf_open then
            vim.cmd('cclose')
        else
            vim.cmd('copen')
        end
    end, { desc = "quickfix: toggle" })
end



M.plugin_spec = {
    "kevinhwang91/nvim-bqf",

    opts = {
        preview = {
            winblend = 0,
            win_height = 999, -- large value means "full" mode
            wrap = true,
        },
    },

    config = function(_,opts)
        require("bqf").setup(opts)

        limit_quickfix_window_height(3)
        set_quickfix_toggle_keymap()
    end
}


return M
