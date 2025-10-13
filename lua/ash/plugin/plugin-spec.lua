return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "rose-pine/neovim",
        name = "rose-pine"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate"
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.8',
        dependencies = { "nvim-lua/plenary.nvim" },
    }
}
