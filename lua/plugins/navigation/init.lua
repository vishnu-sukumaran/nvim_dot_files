-- Returns spec list of plugins that helps in navigating in or across files.
local current_dir = "plugins.navigation"

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
    get_plugin_spec("cscope_maps"),
    get_plugin_spec("fzf"),
    get_plugin_spec("fzf_lua"),
    get_plugin_spec("nvim_telescope"),
    get_plugin_spec("portal"),
}
