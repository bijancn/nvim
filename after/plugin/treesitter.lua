-- [[ Configure Treesitter ]]
-- nvim-treesitter `main` branch: it only installs parsers/queries; highlighting,
-- folding (see set.lua) and incremental selection are built into Neovim 0.12.
-- See `:help nvim-treesitter` and `:help treesitter-incremental-selection`.
local ensure_installed = {
    'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim',
    'java', 'json', 'yaml', 'bash', 'markdown', 'markdown_inline', 'sql', 'comment',
    -- used by go.nvim
    'gomod', 'gowork', 'gosum', 'gotmpl',
}
require('nvim-treesitter').install(ensure_installed)

-- Textobjects
require('nvim-treesitter-textobjects').setup {
    select = {
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    },
    move = {
        set_jumps = true, -- whether to set jumps in the jumplist
    },
}

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('bijancn-treesitter', { clear = true }),
    callback = function(args)
        local buf = args.buf
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not vim.treesitter.get_parser(buf, lang) then return end
        vim.treesitter.start(buf, lang)

        local function undo(command)
            local previous = vim.b[buf].undo_ftplugin
            vim.b[buf].undo_ftplugin = previous and (previous .. ' | ' .. command) or command
        end

        if vim.treesitter.query.get(lang, 'indents') then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            undo('setlocal indentexpr<')
        end

        local function map(modes, keys, action, opts)
            opts.buffer = buf
            vim.keymap.set(modes, keys, action, opts)
            for _, mode in ipairs(type(modes) == 'table' and modes or { modes }) do
                undo(("if get(maparg('%s', '%s', 0, 1), 'buffer', 0) | execute '%sunmap <buffer> %s' | endif")
                    :format(keys, mode, mode, keys))
            end
        end

        -- Incremental selection (built into Nvim 0.12 as `an` / `in` in visual mode)
        map('n', '<c-space>', 'van', { remap = true, desc = 'Start treesitter selection' })
        map('x', '<c-space>', 'an', { remap = true, desc = 'Expand selection to parent node' })
        map('x', '<M-space>', 'in', { remap = true, desc = 'Shrink selection to child node' })

        if not vim.treesitter.query.get(lang, 'textobjects') then return end

        local select = require('nvim-treesitter-textobjects.select')
        for keys, capture in pairs({
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
        }) do
            map({ 'x', 'o' }, keys, function()
                select.select_textobject(capture, 'textobjects')
            end, { desc = 'Select ' .. capture })
        end

        local move = require('nvim-treesitter-textobjects.move')
        for keys, m in pairs({
            [']m'] = { move.goto_next_start, '@function.outer' },
            [']]'] = { move.goto_next_start, '@class.outer' },
            [']M'] = { move.goto_next_end, '@function.outer' },
            [']['] = { move.goto_next_end, '@class.outer' },
            ['[]'] = { move.goto_previous_end, '@class.outer' },
            ['[m'] = { move.goto_previous_start, '@function.outer' },
            ['[['] = { move.goto_previous_start, '@class.outer' },
            ['[M'] = { move.goto_previous_end, '@function.outer' },
        }) do
            map({ 'n', 'x', 'o' }, keys, function()
                m[1](m[2], 'textobjects')
            end, { desc = 'Move to ' .. m[2] })
        end

        local swap = require('nvim-treesitter-textobjects.swap')
        map('n', '<leader>a', function() swap.swap_next('@parameter.inner') end,
            { desc = 'Swap with next parameter' })
        map('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end,
            { desc = 'Swap with previous parameter' })
    end,
})
