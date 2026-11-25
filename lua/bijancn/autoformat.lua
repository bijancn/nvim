-- autoformat.lua
--
-- Format on save is handled by conform.nvim (see `format_on_save` in
-- bijancn/lazy.lua), which falls back to the LSP formatter when no conform
-- formatter is configured for the filetype (JS/TS use prettier, not ts_ls).
--
-- Use :KickstartFormatToggle to toggle autoformatting on or off.
vim.g.autoformat_enabled = true
vim.api.nvim_create_user_command('KickstartFormatToggle', function()
    vim.g.autoformat_enabled = not vim.g.autoformat_enabled
    print('Setting autoformatting to: ' .. tostring(vim.g.autoformat_enabled))
end, {})
