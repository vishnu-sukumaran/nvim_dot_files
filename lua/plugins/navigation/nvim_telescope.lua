local M = {}
-- telescope picker

-- Other functionalities in the module

--- Get the selected item from the telescope picker.
-- The default behavior of builtin.<function> APIs is to do some action on the
-- selected item when we press <CR>. Here we override that behavior to return
-- the highlighted item (string) when <CR> is pressed.
--
-- Since the builtin.<function> APIs are asynchronous and doesn't return a
-- value directly, we design as if we have to pass a callback which will be
-- called when an item is selected and the selected string is passed to the
-- callback function
M.get_selected_val_from_picker = function(action_on_selected_val, picker)
    picker = picker or "log"
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local builtin = require("telescope.builtin")

    -- Maps the key to select an item and the backend action to be taken with the value.
    local map_selection_trigger_key_and_action = function(_, map)
        -- Get the highlighted text when <CR> is pressed.
        local get_selected_value = function(prompt_bufnr)
            -- Get value under the current selection.
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            -- Take the action on the received value.
            if selection and selection.value then
                action_on_selected_val(selection.value)
            end
        end

        map("i", "<CR>", get_selected_value)
        map("n", "<CR>", get_selected_value)

        return true
    end

    -- Supported list of pickers
    local picker_list = {
        log = builtin.git_commits,
        branch = builtin.git_branches,
    }

    if picker then
        picker_list[picker] { attach_mappings = map_selection_trigger_key_and_action }
    else
        print("Picker " .. picker .. " not supported")
    end
end


local store_picker_item_to_register = function(picker)
    local get_and_store_val = function(reg)
        -- validate register input by the user.
        if not reg or not reg:match("^[a-zA-Z0-9\"*+%-]$") then
            vim.notify("Invalid register: " .. tostring(reg), vim.log.levels.ERROR)
            return
        end

        -- Get the value selected from picker and store it to register.
        M.get_selected_val_from_picker(function(val)
            vim.fn.setreg(reg, val)
        end, picker)
    end

    -- Get the register to be stored from user input.
    vim.ui.input({ prompt = "Enter register: " }, get_and_store_val)
end

local get_nvim_telescope_opts = function()
    local opts = {}
    local lga_actions = require("telescope-live-grep-args.actions")
    local actions = require("telescope.actions")

    opts.extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- Ctrl i is the same as tab. Accidental tab press also triggers this.
                    ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                    ["<C-o>"] = lga_actions.quote_prompt({ postfix = " --iglob {*.c,*.h} --iglob !{**/build/**,*cscope*}" }),
                },
            },
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
        mappings = {
            n = {
                ["<Esc>"] = function() end,     -- Prevents accidental exit of telescope upon Esc
                ["<Leader>x"] = actions.close,  -- Intentional quit
            },
        },
        layout_strategy = 'vertical',
    }

    return opts
end

local set_telescope_keymaps = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find: files" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find: open buffers" })
    vim.keymap.set("n", "<Leader>fB", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", { desc = " Grep: Within the open buffers" })
    vim.keymap.set('n', '<leader>fp', builtin.resume, { desc = "Open previously close picker" })
    vim.keymap.set('n', '<leader>fP', builtin.pickers, { desc = "List all the previous pickers" }) -- picker history
    vim.keymap.set('n', '<leader>fq', builtin.quickfixhistory, { desc = "Find: Quickfix history" }) -- quickfix history
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep: within project" })
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Find: Jump list" })
    vim.keymap.set('n', '<leader>frg', function() store_picker_item_to_register("log") end, { desc = "Git: Store SHA from git log to reg" })
    vim.keymap.set('n', '<leader>frG', function() store_picker_item_to_register("branch") end, { desc = "Git: Store Branch name to reg" })
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
