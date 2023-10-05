local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = { "nvim-lua/plenary.nvim", {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        }, },
    },
    { "rose-pine/neovim", name = "rose-pine" },
    { "mbbill/undotree" },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
    { "ahmedkhalf/project.nvim" }, -- Project manager
    -- file tree
    { "nvim-tree/nvim-tree.lua",          dependencies = { "nvim-tree/nvim-web-devicons" } },
    -- Git status next to the line numbers and allows reverting of chunks
    { "lewis6991/gitsigns.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" }, -- Allows to use eslint as formatter
    { "stevearc/dressing.nvim" },          -- Makes something prettier?
    { "numToStr/Comment.nvim" },           -- commenter
    -- Review LSP errors and similar in popup window
    { "folke/trouble.nvim",               dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-lualine/lualine.nvim" }, -- bottom statusline
    -- top buffer line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    -- Show indentation guide lines
    { "lukas-reineke/indent-blankline.nvim", main = "ibl",                               opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",

    {
        "folke/zen-mode.nvim",
        opts = {
            window = { width = 150 }
        }
    },
    { "folke/twilight.nvim",                 opts = { context = 10, treesitter = false } },

    { "zbirenbaum/copilot.lua" },

    { "numtostr/BufOnly.nvim" },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "navarasu/onedark.nvim" }, -- Theme inspired by Atom
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    }
}, {
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "onedark" },
    },
})
