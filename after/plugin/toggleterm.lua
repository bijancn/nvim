function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.keymap.set('n', '<leader>tts', function()
    vim.cmd("ToggleTerm direction=horizontal size=20")
end, { desc = "[T]oggle[T]erm [s]plit down", noremap = true, silent = true })
vim.keymap.set('n', '<leader>tth', function()
    vim.cmd("ToggleTerm direction=vertical size=100")
end, { desc = "[T]oggle[T]erm split [h]orizontally", noremap = true, silent = true })
