local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Load Packer
require('packer').init({...})

-------------------------------------------------------------------------------
--                          User configuration
-------------------------------------------------------------------------------
local user_config = {}


local function get_theme(theme_name)
    local theme_info = {}

    theme_name = theme_name or "mocha"
    local catppuccin_variants = {mocha = true, latte = true}
    if catppuccin_variants[theme_name] then
        theme_info.name = "catppuccin"
        theme_info.config = {flavour = theme_name, colorscheme = theme_name }
    end

    return theme_info
end

-- { "mocha", "latte"}
user_config.theme = get_theme("mocha")

-------------------------------------------------------------------------------

require('plugins').setup()
require('settings').setup(user_config)
require('keybindings')
