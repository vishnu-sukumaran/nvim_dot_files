local M = {}
-- Shows addition, deletion and change signs.
-- Handles hunks - Stage, reset, preview, etc...

local gitsigns_on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
        else
            gitsigns.nav_hunk('next')
        end
    end, { desc = "Nex hunk" })

    map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
        else
            gitsigns.nav_hunk('prev')
        end
    end, { desc = "Prev hunk" })

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })

    map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = "Stage hunk" })

    map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = "Reset hunk" })

    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

    map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff this file" })

    map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
    end, { desc = "Diff - need to be tested" })

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "Create quicklist of repo hunks" })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = "Create quicklist of buffer hunks" })

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "Select hunk" })
    map('n', '<leader>ih', gitsigns.select_hunk, { desc = "Select hunk" })
end

M.plugin_spec = {
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = gitsigns_on_attach,
    },

    config = function(_,opts)
        require("gitsigns").setup(opts)
        require("scrollbar.handlers.gitsigns").setup()
    end
}

return M
