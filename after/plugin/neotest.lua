vim.keymap.set('n', '<leader>tt', function() require("neotest").run.run() end,
    { desc = 'Test test closest to the cursor' })
vim.keymap.set('n', '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end,
    { desc = 'Test current file' })
vim.keymap.set('n', '<leader>ts', function() require("neotest").summary.toggle() end, { desc = 'Toggle test summary' })
-- vim.keymap.set('n', '<leader>tw', function() require("neotest").watch.toggle() end)
vim.keymap.set("n", "<leader>tw",
    function() require('neotest').run.run({ vim.fn.expand("%"), jestCommand = 'jest --watch ' }) end,
    { desc = 'Run tests for current file in watch mode' }
)
