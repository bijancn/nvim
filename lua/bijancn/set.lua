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

vim.opt.foldmethod = "expr"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Empty foldtext renders the folded line with its syntax highlighting
-- (vim.treesitter.foldtext was removed in Nvim 0.12)
vim.opt.foldtext = ""
vim.opt.fillchars:append({ fold = " " })

-- Disable remote-plugin providers that aren't used (silences :checkhealth)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- Make Go tools installed by go.nvim (gopls, goimports, ...) visible to nvim
local gobin = vim.env.GOBIN or ((vim.env.GOPATH or (vim.env.HOME .. "/go")) .. "/bin")
if vim.fn.isdirectory(gobin) == 1 and not vim.env.PATH:find(gobin, 1, true) then
    vim.env.PATH = gobin .. ":" .. vim.env.PATH
end
