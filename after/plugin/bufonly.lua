-- vim.keymap.set('n', '<leader>bo', vim.cmd.BufOnly)
vim.keymap.set("n", "<leader>bo", function()
    vim.cmd('%bdelete|edit #|normal `"')
end)
