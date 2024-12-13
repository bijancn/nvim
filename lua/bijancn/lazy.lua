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
    { "ggandor/leap.nvim", dependencies = { "tpope/vim-repeat" } },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            -- OR 'ibhagwan/fzf-lua',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require "octo".setup()
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = { shade_terminals = false
        }
    },
    {
        'topaxi/gh-actions.nvim',
        keys = {
            { '<leader>gh', '<cmd>GhActions<cr>', desc = 'Open Github Actions' },
        },
        -- optional, you can also install and use `yq` instead.
        build = 'make',
        ---@type GhActionsConfig
        opts = {},
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'haydenmeade/neotest-jest',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-jest')({
                        jestCommand = "npm run test -- --silent=false",
                        -- jestConfigFile = "custom.jest.config.ts",
                        env = { CI = true },
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                    }),
                }
            })
        end
    },
    -- Seems to break Neogit ?!
    -- { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
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
    { "mbbill/undotree" },
    {
        "NeogitOrg/neogit",
        -- cmd = "Neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },
    {
        "tpope/vim-projectionist",
        config = function()
            vim.g.projectionist_heuristics = {
                ["*"] = {
                    ["src/main/java/*.java"] = {
                        alternate = "src/test/java/{}test.java",
                    },
                    ["src/test/java/*test.java"] = {
                        alternate = "src/main/java/{}.java",
                    },
                    ["*.ts"] = {
                        alternate = "{}.spec.ts",
                    },
                    ["*.spec.ts"] = {
                        alternate = "{}.ts",
                    },
                },
            }
        end,
    },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "kristijanhusak/vim-create-pr" },
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
    -- Review LSP errors and similar in popup window
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        opts = {},
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    { "nvim-lualine/lualine.nvim" }, -- bottom statusline
    -- top buffer line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    -- Show indentation guide lines
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",

    {
        "folke/zen-mode.nvim",
        opts = {
            window = { width = 100 }
        }
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        lazy = true,
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = false,
                    auto_trigger = true,
                    keymap = {
                        accept = "<M-j>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<Tab>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
                filetypes = {
                    yaml = true,
                    markdown = false,
                    norg = false,
                    help = false,
                    gitcommit = true,
                    gitrebase = true,
                    ["."] = false,
                }
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua",
        },
        config = function()
            require("copilot_cmp").setup()
        end
    },


    { "AndrewRadev/linediff.vim" },

    { "numToStr/Comment.nvim" },

    { "numtostr/BufOnly.nvim" },

    { "numToStr/FTerm.nvim" },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    { "navarasu/onedark.nvim" }, -- Theme inspired by Atom
    { "rose-pine/neovim",     name = "rose-pine" },
    {
        "f-person/auto-dark-mode.nvim",
        config = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option("background", "dark")
                vim.cmd("colorscheme onedark")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option("background", "light")
                vim.cmd("colorscheme onedark")
            end,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
        opts = {
            -- add any opts here
        },
        config = {
            provider = "openai",
            openai = {
                model = "gpt-4o",
                -- api_key_name = "cmd:gopass show -o websites/openai.com/openai.com@bijan.cloud"
                api_key_name = "cmd:sh /Users/bcn/repos/bcn_scripts/bin/get-openapi-key"
            }
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below is optional, make sure to setup it properly if you have lazy=true
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }

}, {
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "onedark" },
    },
})
