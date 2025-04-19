local M = {}

vim.o.number = true
vim.o.relativenumber = true
-- vim.o.cursorline = true

-- vim.o.visualbell = true

vim.o.textwidth = 79

-- TO CHECK formatoptions
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true


vim.o.scrolloff = 3

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
-- vim.opt.smartindent = false

-- fold settings
vim.o.foldmethod = "syntax"
vim.o.foldenable = false

-- Create a user command for toggling copy mode
local ibl = require('plugins.ui.indent_blankline')
local cp_mode = true
vim.api.nvim_create_user_command('ToggleCp', function()
    if cp_mode then
        ibl.set_ibl(false)
        vim.o.number = false
        vim.o.relativenumber = false
    else
        ibl.set_ibl(true)
        vim.o.number = true
        vim.o.relativenumber = true
    end

    cp_mode = not cp_mode
end, {})

return M
