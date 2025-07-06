-- Keybindings not specific to any plugins

-- Jumping b/w buffers
vim.keymap.set("n", "<Leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<Leader>bp", ":bp<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Delete buffer" })

vim.keymap.set("n", "<Leader><Space>", ":nohl<CR>", { desc = "Clear search highight" })

-- \v - All characters have special meaning if they have it unless escaped with '/'.
-- \C - Case sensitive
-- map("n", "/", "/\\v\\C")
vim.keymap.set("n", "/", "/\\v", { desc = "Search" })
