require('gitsigns').setup({
    signs                        = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Navigate to next hunk' })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'Navigate to previous hunk' })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Hunk: Stage Changes' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Hunk: Reset Changes' })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = 'Hunk: Stage Changes of selection' })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = 'Hunk: Reset Changes of selection' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Hunk: Stage ALL Changes in buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Hunk: Undo Stage Changes' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Hunk: Reset ALL Changes in buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Hunk: Preview Changes' })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end,
            { desc = 'Hunk Blame: Show commit of current line' })
        map('n', '<leader>gb', gs.toggle_current_line_blame,
            { desc = 'Git Blame: Toggle showing the author at end of line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Hunk: Diff file against stage' })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Hunk: Diff file against index' })
    end
})
