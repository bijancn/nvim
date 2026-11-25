vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Buffers
vim.keymap.set("n", "<leader>bv", ':e <c-r>=expand("%:p:h")<cr>/<cr>',
    { desc = "Open new buffer with directory of current file via file manager" })
vim.keymap.set("n", "<leader>be", ':e <c-r>=expand("%:p:h")<cr>/',
    { desc = "Open new buffer with directory of current file via line" })
vim.keymap.set("n", "<M-j>", ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set("n", "<M-k>", ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", ':bd<CR>', { desc = "Delete current buffer" })

-- Windows
vim.keymap.set("n", "<C-w>h", ':vsplit<CR>', { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Move lines around when selected visually
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor fixed when joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in the middle when navigating search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>so", ":source ~/.config/nvim/init.lua<CR>")

vim.keymap.set("n", "<leader>no", ":noh<CR>", { desc = "Turn off highlighting until the next search" })

vim.keymap.set("x", "p", [["_dP]], { desc = "Allow to overpaste while keeping the original text copied" })

-- Allow to exit vertical edit with CTRL-C while keeping the changes in all lines
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Q is weird
vim.keymap.set("n", "Q", "<nop>")

local function show_diagnostic(diagnostic, buf)
    if diagnostic then vim.diagnostic.open_float({ bufnr = buf, scope = 'cursor', focus = false }) end
end

-- Go to next/previous diagnostic
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, on_jump = show_diagnostic }) end,
    { silent = true, desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, on_jump = show_diagnostic }) end,
    { silent = true, desc = 'Previous diagnostic' })

vim.keymap.set("n", "<leader>suw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Substitute word you are currently on' })

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- <leader>oi (organize imports) is set per buffer in after/plugin/lsp.lua
