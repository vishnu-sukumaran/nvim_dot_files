local M = {}
-- <space> and <space><space> allows you to jump anywhere.

local leap_keymap_set = function()
    vim.keymap.set({ 'n', 'x', 'o' }, '<space>', '<Plug>(leap-forward)', { desc = "Leap forward: Type next 2 characters" })
    vim.keymap.set({ 'n', 'x', 'o' }, '<space><space>', '<Plug>(leap-backward)', { desc = "Leap backward: Type next 2 characters" })
    vim.keymap.set({ 'n', 'x', 'o' }, 'g<space>', '<Plug>(leap-from-window)', { desc = "Leap accross windows" })
end

M.plugin_spec = {
    "ggandor/leap.nvim",

    config = function()
        require("leap").setup {}
        leap_keymap_set()
    end
}

return M
