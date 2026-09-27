-- Enables neovim's native treesitter
vim.api.nvim_create_autocmd("FileType", {
pattern = "*",
callback = function()
    pcall(vim.treesitter.start) -- skip filestypes with no parser installed

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldenable = false
end,
})
