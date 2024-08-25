return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>g", "<Esc>:vertical Git<CR>")
    end
}
