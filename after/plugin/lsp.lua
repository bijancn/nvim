-- [[ Configure LSP ]]
-- Uses the native Neovim 0.11+ API (vim.lsp.config / vim.lsp.enable).
-- Server definitions come from nvim-lspconfig's `lsp/` directory, binaries are
-- installed with Mason, and mason-lspconfig enables every installed server.

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local servers = {
    -- clangd = {},
    gopls = {}, -- go.nvim's :GoFmt and format-on-save for Go rely on it
    -- pyright = {},
    -- rust_analyzer = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    ts_ls = {},
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            }
        },
    },
}

for server_name, cfg in pairs(servers) do
    vim.lsp.config(server_name, cfg)
end

require('mason').setup({})
-- Ensure the servers above are installed; every Mason-installed server is enabled.
require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = true,
}

local function organize_imports()
    vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports' }, diagnostics = {} },
        apply = true,
    })
end

--  This function gets run when an LSP connects to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('bijancn-lsp-attach', { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('<leader>oi', organize_imports, '[O]rganize [I]mports')
        -- Keymaps previously provided by lsp-zero's default_keymaps
        nmap('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('<F2>', vim.lsp.buf.rename, 'Rename')
        nmap('<F3>', function() require('conform').format({ bufnr = bufnr, lsp_format = 'fallback' }) end, 'Format buffer')
        nmap('<F4>', vim.lsp.buf.code_action, 'Code Action')
        nmap('<leader>fm', function() require('conform').format({ bufnr = bufnr, lsp_format = 'fallback' }) end,
            '[F]or[m]at buffer')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('gi', vim.lsp.buf.implementation, '[G]oto [i]mplementation')
        nmap('go', vim.lsp.buf.type_definition, '[G]oto type definition')
        nmap('gl', vim.diagnostic.open_float, 'Show diagnostic')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ss', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch workspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            require('conform').format({ bufnr = bufnr, lsp_format = 'fallback' })
        end, { desc = 'Format current buffer' })
        vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', organize_imports,
            { desc = 'Organize imports' })
    end,
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local has_words_before = function()
    if vim.bo.buftype == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'vim-dadbod-completion' },
        { name = 'luasnip' },
    },
}
