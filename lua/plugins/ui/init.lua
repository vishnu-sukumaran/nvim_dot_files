-- Returns spec list which enhances the UI experience and utilities
local current_dir = "plugins.ui"

-- Get plugin_spec from plugin.lua
local get_plugin_spec = function(plugin)
    local plugin_path = current_dir .. "." .. plugin
    local ok, mod = pcall(require, plugin_path)

    if ok then
        return mod.plugin_spec
    else
        -- Lazy will neglect empty table thus other modules are unaffected by the error
        print(current_dir .. ":Error loading " .. plugin)
        return {}
    end
end

-- Return plugin spec list for lazy.nvim
return {
    get_plugin_spec("nvim_web_devicons"),
    get_plugin_spec("catppuccin"),
    get_plugin_spec("lualine"),
    get_plugin_spec("indent_blankline"),
    get_plugin_spec("nvim_tree"),
    get_plugin_spec("scrollbar"),
    get_plugin_spec("neoscroll"),
    get_plugin_spec("dressing"),
}
