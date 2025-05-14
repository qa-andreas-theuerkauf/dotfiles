-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.o.termguicolors = true

require("lazy").setup({
    { 
        "catppuccin/nvim", as = "catppuccin" 
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "timofurrer/edelweiss",
        lazy = false, -- make sure we load this during startup, because it's the main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/nvim")
            vim.cmd([[colorscheme edelweiss]])
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }
    },
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = false
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp'}
    },
    {
        'epwalsh/obsidian.nvim',
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 
        'robitx/gp.nvim',
    },
    -- Fast word jumping
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter"
            },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        }
    },
    -- Smooth scrolling with cinnamon
    {
        "declancm/cinnamon.nvim",
        version = "*", -- use latest release
        opts = {
            --change default options here
        }
    },
    -- Effortless surrounds
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
--    {
--        "nvim-neo-tree/neo-tree.nvim",
--        branch = "v3.x",
--        dependencies = {
--            "nvim-lua/plenary.nvim",
--            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--            "MunifTanjim/nui.nvim",
--            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
--        },
--        lazy = false, -- neo-tree will lazily load itself
--        ---@module "neo-tree"
--        ---@type neotree.Config?
--        opts = {
--            -- fill any relevant options here
--            {
--                "nvim-neo-tree/neo-tree.nvim",
--                branch = "v3.x",
--                dependencies = {
--                    "nvim-lua/plenary.nvim",
--                    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--                    "MunifTanjim/nui.nvim",
--                    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
--                },
--                lazy = false, -- neo-tree will lazily load itself
--                ---@module "neo-tree"
--                ---@type neotree.Config?
--                opts = {
--                    -- fill any relevant options here
--                },
--            }
--        },
--    },
    --    {
    --        'karb94/neoscroll.nvim'
    --    }
})
