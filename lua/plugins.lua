local M = {}
local packer = require 'packer'


-- packer.startup(callback)
function M.setup()
    local function callback()
        use 'wbthomason/packer.nvim'

        use "nvim-lua/plenary.nvim"

        use {
            'serenevoid/kiwi.nvim', 
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        use "kyazdani42/nvim-web-devicons"

        use 'nvim-lualine/lualine.nvim'

        -- -- create the config function
        -- local function catppuccin_config()
        -- end
        --
        -- -- inject flavour into environment
        -- setfenv(catppuccin_config, setmetatable({ flavour = catppuccin_flavour }, { __index = _G }))

        use {
            "catppuccin/nvim",
            as = "catppuccin",
            -- config = catppuccin_config
        }

        use "karb94/neoscroll.nvim"

        use "tpope/vim-repeat"

        use "ggandor/leap.nvim"

        use 'nvim-tree/nvim-tree.lua'

        --[[ Notes:
        -- Neovim has an inbuilt lsp client. Try :lua vim.lsp.<tab> to see the
        -- apis of the nvim's in-built lsp.
        -- Editor is (or has) an LSP client and send info like - A particular
        -- file is open, cursor positions, the lines changed these info asks
        -- the definition of the symbol under cursor, etc... to the lsp server
        -- which is another application. LSP server will reply with reply with
        -- the errors, the file and line location of the symbol queried by the
        -- lsp client (editor or inside editor)
        ]]--
        use "williamboman/mason.nvim"                        	-- To install LSP servers (kind of like LSP manager)

        use "williamboman/mason-lspconfig.nvim"                	-- A binding between the nvim-lspconfig and mason.

        use "neovim/nvim-lspconfig"                             -- Contains the data necessary to link the LSP server installed with mason (or by you manually) to the builtin lsp client of neovim.

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        use 'stevearc/dressing.nvim'

        use {
            -- "nvim-telescope/telescope.nvim", tag = '0.1.4',
            -- "nvim-telescope/telescope.nvim", branch = '0.1.x',
            "nvim-telescope/telescope.nvim", branch = 'master',
            requires = {
                { "nvim-telescope/telescope-live-grep-args.nvim" },
            },
            config = function()
                require("telescope").load_extension("live_grep_args")
            end
        }

        use "dhruvasagar/vim-table-mode"

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
        }

        use "nvim-treesitter/nvim-treesitter-textobjects"

        -- gets the context of where you are like vscode and shows at the top.
        use {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                require("treesitter-context").setup {
                    max_lines = 3,
                    trim_scope = 'outer',
                }
            end
        }

        use {
            "kylechui/nvim-surround",
            tag = "*", -- Use for stability; omit to use `main` branch for the latest features
            config = function()
                require("nvim-surround").setup {
                    -- Configuration here, or leave empty to use defaults
                }
            end
        }

        use {
            "dhananjaylatkar/cscope_maps.nvim",
            config = function()
                require('cscope_maps').setup()
            end
        }

        use "lukas-reineke/indent-blankline.nvim"

        use {
            'junegunn/fzf',
            run = function()
                vim.fn['fzf#install']()
            end
        }

        use "ibhagwan/fzf-lua"

        use 'kevinhwang91/nvim-bqf'

        use 'jeetsukumaran/vim-indentwise'

        -- for easily jumping the jumplist
        use {
            "cbochs/portal.nvim",
            -- Optional dependencies
            requires = {
                "cbochs/grapple.nvim",
                "ThePrimeagen/harpoon"
            },
        }

        use 'jackysee/telescope-hg.nvim'

        use "sindrets/diffview.nvim"

        -- for git blame
        use "lewis6991/gitsigns.nvim"

        -- temporary scratchpad
        use "LintaoAmons/scratch.nvim"

        -- for git integration
        use "tpope/vim-fugitive"

        use 'kkharji/sqlite.lua' -- required for bookmarks.nvim

        use {
            "LintaoAmons/bookmarks.nvim",
            -- pin the plugin at specific version for stability
            -- backup your bookmark sqlite db when there are breaking changes
            -- tag = "v2.3.0",
            dependencies = {
                {"kkharji/sqlite.lua"},
                {"nvim-telescope/telescope.nvim"},
                {"stevearc/dressing.nvim"} -- optional: better UI
            },
            config = function()
                local opts = {} -- go to the following link to see all the options in the deafult config file
                require("bookmarks").setup(opts) -- you must call setup to init sqlite db
            end,
        }

        use 'kevinhwang91/nvim-hlslens'

        use 'petertriho/nvim-scrollbar'
    end

    packer.startup(callback)
end

return M
