local M = {}
-- telescope picker

local get_nvim_telescope_opts = function()
    local opts = {}
    local lga_actions = require("telescope-live-grep-args.actions")

    opts.extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                    ["<C-o>"] = lga_actions.quote_prompt({ postfix = " --iglob {*.c,*.h} --iglob !{**/build/**,*cscope*}" }),
                },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        }
    }

    opts.defaults = {
        -- To store the previous pickers into the picker cache.
        cache_picker = {
            num_pickers = 20, -- adding too much to the cache will slow down the nvim
            limit_entries = 1 -- limit no. of entires within each picker to 1
        },
        layout_config = {
            vertical = {
                preview_cutoff = 0,
                height = 0.9,
                width = 0.9
            },
        },
        layout_strategy = 'vertical',
    }

    return opts
end

local set_telescope_keymaps = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find open buffers" })
    vim.keymap.set("n", "<Leader>fB", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", { desc = " Grep within the open buffers" })
    vim.keymap.set('n', '<leader>fp', builtin.resume, { desc = "Open previously close picker" })
    vim.keymap.set('n', '<leader>fP', builtin.pickers, { desc = "List all the previous pickers" }) -- picker history
    vim.keymap.set('n', '<leader>fq', builtin.quickfixhistory, { desc = "Find Quickfix history" }) -- quickfix history
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep within project" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
    vim.keymap.set('n', '<leader>fl', builtin.loclist, {})
end

M.plugin_spec = {
    -- "nvim-telescope/telescope.nvim", tag = '0.1.4',
    -- "nvim-telescope/telescope.nvim", branch = '0.1.x',
    "nvim-telescope/telescope.nvim", branch = 'master', -- for latest
    dependencies = {
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { 'nvim-lua/plenary.nvim' },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup(get_nvim_telescope_opts())
        telescope.load_extension("live_grep_args")
        set_telescope_keymaps()
    end
}

return M
