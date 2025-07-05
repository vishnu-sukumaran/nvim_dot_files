-- Returns spec list of plugins which add useful tools.
local current_dir = "plugins.tools"

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
    get_plugin_spec("vim_repeat"),
    get_plugin_spec("leap"),
    get_plugin_spec("comment"),
    get_plugin_spec("nvim_surround"),
    get_plugin_spec("vim_table_mode"),
    get_plugin_spec("which_key"),
    get_plugin_spec("bookmarks"),
    get_plugin_spec("nvim_bqf"),
    get_plugin_spec("vim_indentwise"),
    get_plugin_spec("markdown_preview"),
}
