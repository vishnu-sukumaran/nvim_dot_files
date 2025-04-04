require("ibl").setup()

-- Define a variable to keep track of the current state
local plugin_en = true

-- Function to set the plugin
local function set_ibl(enable)
    if enable then
        -- Enable the plugin with default parameters
        require('ibl').setup({})
    else
        -- Disable the plugin
        require('ibl').setup({ enabled = false })
    end

    plugin_en = enable
end


local function get_ibl(enable)
    return plugin_en
end

-- Return the function so it can be used elsewhere
return {
    set_ibl = set_ibl,
    get_ibl = get_ibl
}
