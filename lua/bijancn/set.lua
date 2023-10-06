-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50 -- how often to update in ms

vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamed"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Not yet released
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
