local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    -- print("treesitter.lua status not ok")
    return
end

configs.setup {
    ensure_installed = {"c", "lua", "vimdoc", "markdown", "markdown_inline"},
    sync_install = true,
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = false
    },
}
