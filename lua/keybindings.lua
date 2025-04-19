-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Jumping b/w buffers
map("n", "<Leader>s", ":bn<CR>")                        -- Next Buffer
map("n", "<Leader>a", ":bn<CR>")                        -- Prev Buffer
map("n", "<Leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>")   -- Delete Buffer


map("n", "<Leader><Space>", ":nohl<CR>")                -- clears search highlight

-- \v - All characters have special meaning if they have it unless escaped with '/'.
-- \C - Case sensitive
-- map("n", "/", "/\\v\\C")
map("n", "/", "/\\v")
