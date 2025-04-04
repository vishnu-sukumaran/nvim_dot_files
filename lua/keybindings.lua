-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map("n", "<Leader>T", ":NvimTreeFindFileToggle<CR>")
map("n", "<Leader>t", ":TSContextToggle<CR>")
map("n", "<Leader><Space>", ":nohl<CR>")                -- clears search highlight

-- jumping b/w buffers
map("n", "<Leader>s", ":bn<CR>")                            -- Next buffer
map("n", "<Leader>a", ":bp<CR>")                            -- Prev buffer
map("n", "<Leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>")                        -- delete buffer
-- map("n", "<Leader>d", ":ls<CR>:bd ")                        -- delete buffer
map("n", "<Leader>o", "<plug>(openbrowser-open)")      -- open url
map("v", "<Leader>o", "<plug>(openbrowser-open)")      -- open url
map("n", "<Leader>x", "<plug>(openbrowser-search)")    -- open search
map("v", "<Leader>x", "<plug>(openbrowser-search)")    -- open search

-- \v - All characters have special meaning if they have it unless escaped with '/'.
-- \C - Case sensitive
-- map("n", "/", "/\\v\\C")
map("n", "/", "/\\v")


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- find buffer
map("n", "<Leader>fB", ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")    -- open search
vim.keymap.set('n', '<leader>fp', builtin.resume, {}) -- pikcer resume
vim.keymap.set('n', '<leader>fP', builtin.pickers, {}) -- picker history
vim.keymap.set('n', '<leader>fq', builtin.quickfixhistory, {}) -- quickfix history
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fl', builtin.loclist, {})
vim.keymap.set('n', '<leader>ft', builtin.tags, {})
vim.keymap.set('n', '<leader>ft', builtin.tags, {})


--Scratchpad
vim.keymap.set("n", "<leader>tn", "<cmd>ScratchWithName<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>ScratchOpen<cr>")
vim.keymap.set("n", "<leader>tg", "<cmd>ScratchOpenFzf<cr>")


-- Bookmark
vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })


-- portal plugin
vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")


-- For copy mode (disable indent blank line and line numbers)
vim.keymap.set('n', '<leader>y', ":lua require('ibl').setup {enabled = false}<CR>", {})

-- Cscope build
-- map("n", "<Leader>cB", ":!fd -e c -e h > cscope.files<CR>:Cs db build<CR>:!git restore .gitignore; ls *cscope* >> .gitignore<CR>")
map("n", "<Leader>cB", ":!fd -e c -e h > cscope.files<CR>:Cs db build<CR>")
-- map("n", "<C-LeftMouse>", "<cmd>Cs f g<cr>")
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


-- vim.keymap.set({ "n", "v" }, "<C-c><C-g>", "<cmd>Cs f g<cr>")


-- Leap
vim.keymap.set({'n', 'x', 'o'}, '<space>',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, '<space><space>',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'g<Space>', '<Plug>(leap-from-window)')
