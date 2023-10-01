vim.g.mapleader = " "

-- Open new buffer with directory of current file via file manager
vim.keymap.set("n", "<leader>pv", ':e <c-r>=expand("%:p:h")<cr>/<cr>')
-- Open new buffer with directory of current file via line
vim.keymap.set("n", "<leader>be", ':e <c-r>=expand("%:p:h")<cr>/')

-- Move lines around when selected visually
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in front when joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in the middle when half page jumping or navigating search
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- doesn't work?
vim.keymap.set("n", "<leader>so", ":source $MYVIMRC<CR>")

-- Allow to overpaste while keeping the original text copied
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Allow to exit vertical edit with CTRL-C while keeping the changes in all lines
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Q is weird
vim.keymap.set("n", "Q", "<nop>")

-- Quickfix list shortcuts
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitute word you are currently on
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>oi", function()
	vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end)
