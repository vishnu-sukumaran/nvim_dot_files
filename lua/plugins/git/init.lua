-- Returns spec list of Git integration plugins
local current_dir = "plugins.git"

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
    get_plugin_spec("fugitive"),
    get_plugin_spec("diffview"),
    get_plugin_spec("gitsigns"),
}
