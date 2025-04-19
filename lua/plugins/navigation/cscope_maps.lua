local M = {}
-- cscope

local map_ctrl_left_clik_go_to_definition = function()
    -- Function to navigate to definition at mouse position
    -- Define the function globally
    _G.goto_definition_under_mouse = function()
        -- Get the mouse position
        local mouse_pos = vim.fn.getmousepos()

        -- Move the cursor to the mouse position
        vim.api.nvim_win_set_cursor(0, {mouse_pos.line, mouse_pos.column - 1})

        -- Get the word under the mouse
        local word = vim.fn.expand('<cword>')

        -- Use cscope to find the definition of the word
        vim.cmd('Cs find g ' .. word)
    end

    -- Map <C-LeftMouse> to call the function
    vim.api.nvim_set_keymap('n', '<C-LeftMouse>', ':lua goto_definition_under_mouse()<CR>', { noremap = true, silent = true })
end

local cs_stackview_down = function()
    -- Get the word under the cursor
    local word = vim.fn.expand('<cword>')
    vim.cmd('CsStackView open down ' .. word)
end

local cs_stackview_up = function()
    -- Get the word under the cursor
    local word = vim.fn.expand('<cword>')
    vim.cmd('CsStackView open up ' .. word)
end

local configs_suggested_in_repo = function()
    -- Path to store the cscope files (cscope.files and cscope.out)
    vim.cmd([[let g:cscope_dir = '~/.nvim-cscope']])

    -- Map the default keys on startup
    -- These keys are prefixed by CTRL+\ <cscope param>
    -- A.e.: CTRL+\ d for goto definition of word under cursor
    -- Defaults to off
    vim.cmd([[let g:cscope_map_keys = 1]])

    -- Update the cscope files on startup of cscope.
    -- Defaults to off
    vim.cmd([[let g:cscope_update_on_start = 1]])
    vim.cmd([[set cursorline]])
    vim.cmd([[set foldmethod=expr]])
    vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

    -- vim.cmd([[autocmd VimEnter * CScopeStart]])
    -- vim.cmd([[autocmd VimEnter * CScopeMapKeys]])
    -- vim.cmd([[autocmd VimEnter * CScopeUpdate]])
end

M.plugin_spec = {
    "dhananjaylatkar/cscope_maps.nvim",

    opts = {
        cscope = {
            picker = "telescope"
        }
    },

    config = function(_, opts)
        require("cscope_maps").setup(opts)
        configs_suggested_in_repo()
        vim.api.nvim_set_keymap("n", "<Leader>cB", ":!fd -e c -e h > cscope.files<CR>:Cs db build<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<Leader>cj", ":lua cs_stackview_down()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<Leader>ck", ":lua cs_stackview_up()<CR>", { noremap = true, silent = true })
        map_ctrl_left_clik_go_to_definition()
    end,
}

return M
