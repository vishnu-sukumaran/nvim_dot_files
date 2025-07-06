local M = {}
-- telescope picker


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



M.store_picker_item_to_register = function(picker)
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


return M
