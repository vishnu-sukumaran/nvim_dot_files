local M = {}
-- Operates only on the git hunk.

-- Local state for search match navigation
local search_active = false
local matched_lines = {}
local current_match_index = 0

-- Helper: get hunks or return nil with notification
local function get_current_hunks()
    local gs = package.loaded.gitsigns
    local bufnr = vim.api.nvim_get_current_buf()
    local hunks = gs.get_hunks(bufnr)
    if not hunks then
        vim.notify("No hunks found", vim.log.levels.INFO)
        return nil
    end
    return hunks, bufnr
end

-- Action: Apply :[range]cmd (e.g., substitute)
local function apply_range_command(hunks, bufnr, cmd_template)
    for _, hunk in ipairs(hunks) do
        local start = hunk.added.start
        local count = hunk.added.count
        if count == 0 then goto continue end

        local first = start
        local last = start + count - 1
        local cmd = string.format('%d,%d %s', first, last, cmd_template)

        local ok, err = pcall(vim.cmd, cmd)
        if not ok then
            vim.schedule(function()
                vim.api.nvim_echo({ { "GitsignsHunkOp failed: " .. cmd .. " → " .. err, "WarningMsg" } }, false, {})
            end)
        end

        ::continue::
    end
end

-- Action: Apply normal-mode keys (e.g., ==, >>)
local function apply_normal_keys(hunks)
    for _, hunk in ipairs(hunks) do
        local start = hunk.added.start
        local count = hunk.added.count
        if count == 0 then goto continue end

        for lnum = start, start + count - 1 do
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            vim.cmd('normal! ' .. hunk.normal_keys)
        end

        ::continue::
    end
end

-- Action: Highlight + jump to search matches
local function highlight_and_jump_matches(hunks, bufnr, pattern)
    local jumped = false

    -- Store and reuse namespace
    if not M._search_ns then
        M._search_ns = vim.api.nvim_create_namespace("GitsignsHunkSearch")
    else
        vim.api.nvim_buf_clear_namespace(bufnr, M._search_ns, 0, -1)
    end

    matched_lines = {}
    current_match_index = 0
    search_active = true

    for _, hunk in ipairs(hunks) do
        local start = hunk.added.start
        local count = hunk.added.count
        if count == 0 then goto continue end

        local lines = vim.api.nvim_buf_get_lines(bufnr, start - 1, start + count - 1, false)
        for i, line in ipairs(lines) do
            if line:find(pattern) then
                local lnum = start + i - 1
                table.insert(matched_lines, lnum)
                vim.api.nvim_buf_add_highlight(bufnr, M._search_ns, "Search", lnum - 1, 0, -1)
                if not jumped then
                    vim.api.nvim_win_set_cursor(0, { lnum, 0 })
                    jumped = true
                end
            end
        end

        ::continue::
    end

    M._search_pattern = pattern

    -- n: next match
    vim.keymap.set("n", "n", function()
        if not search_active or #matched_lines == 0 then
            return vim.cmd("normal! n")
        end
        current_match_index = (current_match_index % #matched_lines) + 1
        vim.api.nvim_win_set_cursor(0, { matched_lines[current_match_index], 0 })
    end, { buffer = 0, silent = true })

    -- N: previous match
    vim.keymap.set("n", "N", function()
        if not search_active or #matched_lines == 0 then
            return vim.cmd("normal! N")
        end
        current_match_index = (current_match_index - 2 + #matched_lines) % #matched_lines + 1
        vim.api.nvim_win_set_cursor(0, { matched_lines[current_match_index], 0 })
    end, { buffer = 0, silent = true })
end

-- Manual restore of n/N mapping
function M.reset_n_mappings()
    search_active = false
    matched_lines = {}
    current_match_index = 0
    pcall(vim.keymap.del, "n", "n", { buffer = 0 })
    pcall(vim.keymap.del, "n", "N", { buffer = 0 })
end

-- Main dispatcher
local function apply_to_gitsigns_hunks(action)
    local hunks, bufnr = get_current_hunks()
    if not hunks then return end

    if action.range_cmd then
        apply_range_command(hunks, bufnr, action.range_cmd)
    elseif action.normal_keys then
        for _, h in ipairs(hunks) do h.normal_keys = action.normal_keys end
        apply_normal_keys(hunks)
    elseif action.search_pattern then
        highlight_and_jump_matches(hunks, bufnr, action.search_pattern)
    end
end

-- Command: GitsignsHunkSearchDisable
-- Fully disable GitsignsHunkOp search mode
local function setup_disable_command()
    vim.api.nvim_create_user_command("GitsignsHunkSearchDisable", function()
        -- Restore native 'n' and 'N'
        M.reset_n_mappings()

        -- Clear highlight namespace
        if M._search_ns then
            vim.api.nvim_buf_clear_namespace(0, M._search_ns, 0, -1)
            M._search_ns = nil
        end

        -- Clear search pattern and state
        M._search_pattern = nil
        M._search_matches = nil
        M._search_index = nil

        vim.notify("GitsignsHunkOp: Highlight, pattern, and mappings reset", vim.log.levels.INFO)
    end, {
        desc = "Disable hunk search mode, clear highlights, and restore n/N behavior"
    })
end

-- Register :GitsignsHunkOp command
function M.setup_hunk_op_command()
    vim.api.nvim_create_user_command('GitsignsHunkOp', function(opts)
        local input = opts.args
        if input:sub(1, 1) == ':' then input = input:sub(2) end

        if input:match('^s[/%^]') then
            apply_to_gitsigns_hunks({ range_cmd = input })
        elseif input:match('^/') then
            apply_to_gitsigns_hunks({ search_pattern = input:sub(2) })
        else
            apply_to_gitsigns_hunks({ normal_keys = input })
        end
    end, {
        nargs = 1,
        complete = function()
            return {
                's/\\s\\+$//e',
                '/TODO',
                '==',
                'g~g~',
            }
        end,
    })

    -- Register disable command
    setup_disable_command()
end

-- Optional auto listener (disabled for now)
-- local function setup_nohl_listener()
--     vim.api.nvim_create_autocmd("CmdlineEnter", {
--         pattern = ":nohl",
--         callback = M.reset_n_mappings,
--     })
-- end

return M
