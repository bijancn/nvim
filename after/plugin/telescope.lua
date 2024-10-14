-- Add projects.nvim extension
require("project_nvim").setup {
    detection_methods = { "pattern", "lsp" },
    patterns = { "!bijancn", ".git" }
}
require("telescope").load_extension("projects")
vim.keymap.set("n", "<leader>p", function()
    require("telescope").extensions.projects.projects({})
end, { desc = 'telescope: find [p]roject' })

require('telescope').setup {
    pickers = {
        live_grep = {
            additional_args = function(opts)
                return { "--hidden" }
            end
        },
    }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'telescope:[f]ind [o]ld files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'telescope: [f]ind [b]uffers' })
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'telescope: [/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').git_files, { desc = 'telescope: [f]ind [g]it files' })
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end,
    { desc = 'telescope: [f]ind [f]iles' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'telescope: [s]earch [h]elp' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'telescope: [s]earch [k]eymaps' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
    { desc = 'telescope: [s]earch current [w]ord' })
-- TODO: Implement sv searching for currently visually selected
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'telescope: [s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
    { desc = 'telescope: [s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'telescope: [s]earch [r]esume' })
