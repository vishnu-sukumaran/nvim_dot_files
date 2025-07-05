local M = {}
-- LSP autocompletion support using nvim-cmp with better UI and snippet integration

M.plugin_spec = {
    -- 🧠 Main autocompletion engine
    "hrsh7th/nvim-cmp",

    dependencies = {
        -- 🧠 Provides LSP-based completions (e.g., functions, types, variables from your code)
        "hrsh7th/cmp-nvim-lsp",

        -- ✂️ Snippet engine required for snippet expansion (e.g., for-loop template)
        "L3MON4D3/LuaSnip",

        -- 🔌 Adapter to connect LuaSnip with nvim-cmp
        "saadparwaiz1/cmp_luasnip",

        -- 📄 Provides words from the current buffer as completion suggestions
        "hrsh7th/cmp-buffer",

        -- 📁 Enables filesystem path completions
        "hrsh7th/cmp-path",

        -- 🎨 Adds icons (e.g., ƒ for functions, 𝓥 for variables) to completion menu
        "onsails/lspkind.nvim",

        -- 🪄 Automatically inserts closing brackets, quotes, etc.
        -- e.g., typing ( or [ or " will auto-insert the corresponding closing character
        "windwp/nvim-autopairs",
    },

    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        -- 🛠️ Initialize autopairs
        require("nvim-autopairs").setup()
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        cmp.setup({
            -- ✂️ Define how to expand snippets when selected
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            -- ⌨️ Key mappings for completion menu navigation and confirmation
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"]     = cmp.mapping.select_next_item(),
                ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
                ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- confirm selection
                ["<C-Space>"] = cmp.mapping.complete(),                 -- manually trigger completion
            }),

            -- 🎨 Format the menu with icons + kind text (e.g., ƒ Function)
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },

            -- 🪟 Add nice borders to completion and documentation popups
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- 🔍 Configure completion sources
            sources = cmp.config.sources({
                { name = "nvim_lsp" },  -- LSP suggestions
                { name = "luasnip" },   -- snippets
            }, {
                { name = "buffer" },    -- words in open buffer
                { name = "path" },      -- filesystem paths
            }),
        })
    end,
}

return M
