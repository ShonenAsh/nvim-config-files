require("ash.remap")
require("ash.lazy")
require("ash.options")
require("ash.lsp")
require("ash.iron")
require("ash.treesitter")

-- Additional plugins
require('mini.statusline').setup({
    use_icons = true,
    set_vim_settings = true,
})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })

