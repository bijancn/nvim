require('Comment').setup()
local api = require('Comment.api')

vim.keymap.set('n', '<leader>cc', api.toggle.linewise.current)

-- Toggle selection (linewise)
local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
vim.keymap.set('x', '<leader>cc', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
end)
