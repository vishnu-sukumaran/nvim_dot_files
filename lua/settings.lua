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

-- Path to store the cscope files (cscope.files and cscope.out)
-- Defaults to '~/.cscope'
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



-- option dependent module settings
function M.setup(user_config)
	if user_config.theme.name == "catppuccin" then
		require('settings.catppuccin_settings').setup(user_config.theme.config)
	else
		require('settings.catppuccin_settings').setup({})
	end
end

-- Settings for the plugins
require('settings.lualine_settings')
require('settings.nvim-tree_settings')
require('settings.mason_settings')
require('settings.comment_settings')
require('settings.telescope_settings')
require('settings.vim-table-mode')
require('settings.cscope_maps_settings')
require('settings.nvim-treesitter_settings')
local indent_blankline_settings = require('settings.indent-blankline_settings')
require('settings.kiwi_settings')
require('settings.nvim-surround_settings')
require('settings.diffview')
require('settings.nvim-bqf_settings')
require('settings.gitsigns_settings')
require('settings.scratch_settings')
-- require("bookmarks").setup()
require("dressing").setup()
require('settings.nvim-hlslens')
require('settings.nvim-scrollbar')
require('settings.leap')


local function toggle_ibl()
    if indent_blankline_settings.get_ibl() then
        indent_blankline_settings.set_ibl(false)
    else
        indent_blankline_settings.set_ibl(true)
    end
end

-- Create a user command for toggling IBL
vim.api.nvim_create_user_command('ToggleIBL', toggle_ibl, {})

-- Create a user command for toggling copy mode
local cp_mode = true
vim.api.nvim_create_user_command('ToggleCp', function()
    if cp_mode then
        indent_blankline_settings.set_ibl(false)
        vim.o.number = false
        vim.o.relativenumber = false
    else
        indent_blankline_settings.set_ibl(true)
        vim.o.number = true
        vim.o.relativenumber = true
    end

    cp_mode = not cp_mode
end, {})


-- if vim.fn.has('clipboard') == 1 then
--   vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard for all operations
-- end

return M
