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
                suggestion = {
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
        "rebelot/kanagawa.nvim", -- neorg needs a colorscheme with treesitter support
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                highlight = { enable = true },
            },
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
        },
        {
            "vhyrro/luarocks.nvim",
            priority = 1000, -- We'd like this plugin to load first out of the rest
            config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
        },
        {
            "nvim-neorg/neorg",
            dependencies = { "nvim-lua/plenary.nvim", "phenax/neorg-hop-extras", "luarocks.nvim" },
            config = function()
                require("neorg").setup {
                    load = {
                        ["core.defaults"] = {},
                        ["core.journal"] = { config = { strategy = "%Y-%W" } },
                        ["core.concealer"] = {
                            config = {
                                icon_preset = "diamond"
                            }
                        },
                        ["core.export"] = {},
                        ["core.itero"] = {},
                        ["core.promo"] = {},
                        ["core.summary"] = {},
                        ["core.completion"] = { config = { engine = "nvim-cmp" } },
                        ["core.integrations.nvim-cmp"] = {},
                        ['external.hop-extras'] = {
                            config = {
                                aliases = {
                                    tw = 'https://twitter.com/{}',
                                    gh = 'https://github.com/jimdo/{}',
                                    co = 'https://jimplan.atlassian.net/wiki/spaces/{}',
                                    sl = 'https://jimdo.slack.com/archives/{}'
                                },
                            },
                        },
                        ["core.keybinds"] = {
                            config = {
                                hook = function(keybinds)
                                    local leader = keybinds.leader

                                    -- Map all the below keybinds only when the "norg" mode is active
                                    keybinds.map_event_to_mode("norg", {
                                        n = {
                                            -- Marks the task under the cursor as "undone"
                                            -- ^mark Task as Undone
                                            {
                                                leader .. "tu",
                                                "core.qol.todo_items.todo.task_undone",
                                                opts = { desc = "[neorg] Mark as Undone" },
                                            },

                                            -- Marks the task under the cursor as "pending"
                                            -- ^mark Task as Pending
                                            {
                                                leader .. "tp",
                                                "core.qol.todo_items.todo.task_pending",
                                                opts = { desc = "[neorg] Mark as Pending" },
                                            },

                                            -- Marks the task under the cursor as "done"
                                            -- ^mark Task as Done
                                            { leader .. "td", "core.qol.todo_items.todo.task_done",  opts = { desc = "[neorg] Mark as Done" } },

                                            -- Marks the task under the cursor as "on_hold"
                                            -- ^mark Task as on Hold
                                            {
                                                leader .. "th",
                                                "core.qol.todo_items.todo.task_on_hold",
                                                opts = { desc = "[neorg] Mark as On Hold" },
                                            },

                                            -- Marks the task under the cursor as "cancelled"
                                            -- ^mark Task as Cancelled
                                            {
                                                leader .. "tc",
                                                "core.qol.todo_items.todo.task_cancelled",
                                                opts = { desc = "[neorg] Mark as Cancelled" },
                                            },

                                            -- Marks the task under the cursor as "recurring"
                                            -- ^mark Task as Recurring
                                            {
                                                leader .. "tr",
                                                "core.qol.todo_items.todo.task_recurring",
                                                opts = { desc = "[neorg] Mark as Recurring" },
                                            },

                                            -- Marks the task under the cursor as "important"
                                            -- ^mark Task as Important
                                            {
                                                leader .. "ti",
                                                "core.qol.todo_items.todo.task_important",
                                                opts = { desc = "[neorg] Mark as Important" },
                                            },

                                            -- Marks the task under the cursor as "ambiguous"
                                            -- ^mark Task as ambiguous
                                            {
                                                leader .. "ta",
                                                "core.qol.todo_items.todo.task_ambiguous",
                                                opts = { desc = "[neorg] Mark as Ambigous" },
                                            },

                                            -- Switches the task under the cursor between a select few states
                                            { "<C-Space>",    "core.qol.todo_items.todo.task_cycle", opts = { desc = "[neorg] Cycle Task" } },

                                            -- Creates a new .norg file to take notes in
                                            -- ^New Note
                                            { leader .. "nn", "core.dirman.new.note",                opts = { desc = "[neorg] Create New Note" } },

                                            -- Hop to the destination of the link under the cursor
                                            { "<CR>",         "core.esupports.hop.hop-link",         opts = { desc = "[neorg] Jump to Link" } },
                                            { "gd",           "core.esupports.hop.hop-link",         opts = { desc = "[neorg] Jump to Link" } },
                                            { "gf",           "core.esupports.hop.hop-link",         opts = { desc = "[neorg] Jump to Link" } },
                                            { "gF",           "core.esupports.hop.hop-link",         opts = { desc = "[neorg] Jump to Link" } },

                                            -- Same as `<CR>`, except opens the destination in a vertical split
                                            -- {
                                            --     "<M-CR>",
                                            --     "core.esupports.hop.hop-link",
                                            --     "vsplit",
                                            --     opts = { desc = "[neorg] Jump to Link (Vertical Split)" },
                                            -- },

                                            { ">.",           "core.promo.promote",                  opts = { desc = "[neorg] Promote Object (Non-Recursively)" } },
                                            { "<,",           "core.promo.demote",                   opts = { desc = "[neorg] Demote Object (Non-Recursively)" } },

                                            { ">>",           "core.promo.promote",                  "nested",                                                    opts = { desc = "[neorg] Promote Object (Recursively)" } },
                                            { "<<",           "core.promo.demote",                   "nested",                                                    opts = { desc = "[neorg] Demote Object (Recursively)" } },

                                            {
                                                leader .. "lt",
                                                "core.pivot.toggle-list-type",
                                                opts = { desc = "[neorg] Toggle (Un)ordered List" },
                                            },
                                            {
                                                leader .. "li",
                                                "core.pivot.invert-list-type",
                                                opts = { desc = "[neorg] Invert (Un)ordered List" },
                                            },

                                            { leader .. "id", "core.tempus.insert-date",   opts = { desc = "[neorg] Insert Date" } },
                                            { leader .. "nt", "core.itero.next-iteration", "<CR>",                                 opts = { desc = "[neorg] Continue Object" } },
                                        },

                                        i = {
                                            { "<C-t>",  "core.promo.promote",                  opts = { desc = "[neorg] Promote Object (Recursively)" } },
                                            { "<C-d>",  "core.promo.demote",                   opts = { desc = "[neorg] Demote Object (Recursively)" } },
                                            { "<M-CR>", "core.itero.next-iteration",           "<CR>",                                                  opts = { desc = "[neorg] Continue Object" } },
                                            { "<M-d>",  "core.tempus.insert-date-insert-mode", opts = { desc = "[neorg] Insert Date" } },
                                        },

                                        -- TODO: Readd these
                                        -- v = {
                                        --     { ">>", ":<cr><cmd>Neorg keybind all core.promo.promote_range<cr>" },
                                        --     { "<<", ":<cr><cmd>Neorg keybind all core.promo.demote_range<cr>" },
                                        -- },
                                    }, {
                                        silent = true,
                                        noremap = true,
                                    })
                                end,
                            }
                        },
                        ["core.dirman"] = {
                            config = {
                                workspaces = {
                                    notes = "~/drive/orgfiles",
                                },
                                default_workspace = "notes",
                            },
                        },
                    },
                }

                vim.wo.foldlevel = 99
                vim.wo.conceallevel = 2
                vim.cmd('hi @neorg.markup.verbatim.norg guifg=Green')
            end,
        }
    },
    {
        "jellydn/CopilotChat.nvim",
        dependencies = { "zbirenbaum/copilot.lua" }, -- Or { "github/copilot.vim" }
        opts = {
            mode = "split",                          -- newbuffer or split  , default: newbuffer
            debug = true,                            -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
        },
        build = function()
            vim.defer_fn(function()
                vim.cmd("UpdateRemotePlugins")
                vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
            end, 3000)
        end,
        event = "VeryLazy",
        keys = {
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
        },
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function()
            require("chatgpt").setup {
                api_key_cmd = "op read op://Individual/OPENAI_API_KEY/credential --no-newline",
                predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/bijancn/nvim/main/prompts.csv",
                openai_params = {
                    model = "gpt-4o",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 2000,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                }
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            -- "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
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
                model = "gpt-4o"
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
