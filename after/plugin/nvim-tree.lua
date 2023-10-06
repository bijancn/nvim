require("nvim-tree").setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    disable_netrw = false,
    hijack_netrw = true,
})

-- Change working directory to current file
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "Change working directory to current file" })
-- Move working directory one level higher
vim.keymap.set("n", "<leader>..", ":cd ..<CR>:pwd<CR>", { desc = "Move working directory one level higher" })

vim.keymap.set("n", "<leader>tr", vim.cmd.NvimTreeToggle, { desc = "Toggle [T]ree" })
