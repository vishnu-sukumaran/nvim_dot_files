packer = require 'packer'

packer.startup(function()

    use {
        'wbthomason/packer.nvim'
    }

    use {
        "nvim-lua/plenary.nvim"
    }
    
    use {
        'serenevoid/kiwi.nvim', 
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    use {
        "kyazdani42/nvim-web-devicons"
    }

    use {
        'nvim-lualine/lualine.nvim'
    }

    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                flavour = "mocha" -- mocha, macchiato, frappe, latte
            }
            vim.api.nvim_command "colorscheme catppuccin-mocha"
        end
    }

    use {
        "karb94/neoscroll.nvim"
    }

    use "tpope/vim-repeat"

    use "ggandor/leap.nvim"

    -- use {
	   --  "folke/tokyonight.nvim",
    --     as = "tokyonight",
	   --  config = function()
		  --   require("tokyonight").setup {
			 --    style = "day"
		  --   }
		  --   vim.api.nvim_command "colorscheme tokyonight-day"
	   --  end
    -- }
    --
    -- use {
    --     "EdenEast/nightfox.nvim"
    -- }
    -- use {
    --     "EdenEast/nightfox.nvim"
    --     vim.cmd("colorscheme nightfox")
    -- }

    use {
        'nvim-tree/nvim-tree.lua'
    }

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- use {
    --     'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- }

    use {'stevearc/dressing.nvim'}

    use {
        -- "nvim-telescope/telescope.nvim", tag = '0.1.4',
        "nvim-telescope/telescope.nvim", branch = '0.1.x',
        requires = {
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }

    use {
        "dhruvasagar/vim-table-mode"
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
    }

    use {
        "nvim-treesitter/nvim-treesitter-textobjects"
    }

    use {
        'nvim-treesitter/nvim-treesitter-context'
    }


    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use {
        "dhananjaylatkar/cscope_maps.nvim",
        config = function()
            require('cscope_maps').setup()
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim"
    }

    use {'junegunn/fzf', run = function()
        vim.fn['fzf#install']()
    end
    }

    use "ibhagwan/fzf-lua"

    use {
        'kevinhwang91/nvim-bqf'
    }

    use {
        'jeetsukumaran/vim-indentwise'
    }

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
    use {
        "LintaoAmons/scratch.nvim",
        -- event = "VeryLazy"
    }

    -- for git integration
    use {
        "tpope/vim-fugitive"
    }

    use 'kkharji/sqlite.lua' -- required for bookmarks.nvim

    -- use {
    --     "LintaoAmons/bookmarks.nvim"
    -- }

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

end)
