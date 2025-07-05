local M = {}
-- For viewing markdown in web browser.

local function is_wsl()
    local uname = vim.loop.os_uname().release
    return uname:lower():find("microsoft") ~= nil
end

local function is_ssh()
    return vim.env.SSH_CLIENT or vim.env.SSH_TTY
end

-- Determine whether to enable markdown preview
local enable = false
local browser = ""

if is_wsl() and not is_ssh() then
    enable = true
    browser = "/usr/bin/wslview"
elseif is_wsl() and is_ssh() then
    enable = false  -- you're SSHed into WSL. Can be overridden in future.
elseif is_ssh() then
    enable = false  -- Can be overridden in future.
else
    enable = true
    browser = "xdg-open"
end

M.plugin_spec = {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    enabled = enable, -- 🔒 disable when SSH into WSL
    config = function()
        vim.g.mkdp_port = "8090"
        vim.g.mkdp_browser = browser
        vim.g.mkdp_filetypes = { "markdown" }
    end,
}

return M
