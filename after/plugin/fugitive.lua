vim.keymap.set('n', '<leader>gs', vim.cmd.Neogit, { desc = 'Git Status (Neogit)' })
vim.keymap.set('n', '<leader>gb', ':GBrowse<CR>', { desc = 'Git Browse file in Github' })
vim.keymap.set('x', '<leader>gb', ':GBrowse<CR>', { desc = 'Git Browse line selection in Github' })
