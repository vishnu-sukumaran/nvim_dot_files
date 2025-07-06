local M = {}
-- The treesitter plugin.


local treesitter_config = {
    ensure_installed = {"c", "lua", "vimdoc", "markdown", "markdown_inline"},
    auto_install = false,
    -- sync_install = true,
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = true,
    },

    -- disable if file size is huuuuge
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },

        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
            },
        },
    }
}



M.plugin_spec = {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",

    config = function()
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            print("treesitter.lua status not ok")
            return
        end

        configs.setup(treesitter_config)
    end
}



return M
