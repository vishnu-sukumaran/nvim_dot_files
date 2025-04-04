-- require('telescope').setup()

local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        }
    },

    defaults = {
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
        -- preview_cutoff = 1,
        -- loyout_config = {
        --     height = 1,
        --     width = 1
        -- }
    }
}
