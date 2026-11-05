return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({
                -- This callback can be used to override the colors used in the base palette.
                on_palette = function(palette) end,
                -- This callback can be used to override the colors used in the extended palette.
                after_palette = function(palette) end,
                -- This callback can be used to override highlights before they are applied.
                on_highlight = function(highlights, palette)
                    highlights.Comment = { fg = palette.gray5, italic = true }
                end,
                -- Enable bold keywords.
                bold_keywords = false,
                -- Enable italic comments.
                italic_comments = true,
                -- Enable editor background transparency.
                transparent = {
                    -- Enable transparent background.
                    bg = true,
                    -- Enable transparent background for floating windows.
                    float = true,
                },
                -- Enable brighter float border.
                bright_border = true,
                -- Reduce the overall amount of blue in the theme (diverges from base Nord).
                reduced_blue = false,
                -- Swap the dark background with the normal one.
                swap_backgrounds = false,
                -- Cursorline options.
                cursorline = {
                    -- Bold font in cursorline.
                    bold = false,
                    -- Bold cursorline number.
                    bold_number = true,
                    -- Available styles: 'dark', 'light'.
                    theme = 'dark',
                    -- Blending the cursorline bg with the buffer bg.
                    blend = 0.25,
                },
                -- Visual selection options.
                visual = {
                    -- Bold font in visual selection.
                    bold = true,
                    -- Bold visual selection number.
                    bold_number = true,
                    -- Available styles: 'dark', 'light'.
                    theme = 'light',
                    -- Blending the visual selection bg with the buffer bg.
                    blend = 0.25,
                },
                noice = {
                    -- Available styles: `classic`, `flat`.
                    style = 'flat',
                },
                telescope = {
                    -- Available styles: `classic`, `flat`.
                    style = 'flat',
                },
                leap = {
                    -- Dims the backdrop when using leap.
                    dim_backdrop = true,
                },
                ts_context = {
                    -- Enables dark background for treesitter-context window
                    dark_background = true,
                }
            })
            require('nordic').load()
        end
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                -- preset = 'enter',
                preset = 'default',
                ['<UP>'] = { 'fallback' },
                ['<DOWN>'] = { 'fallback' },
                ['<CR>'] = { 'fallback' },
                -- ['<C-CR>'] = { 'select_and_accept', 'fallback' },
                -- ['<C-y>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                documentation = { auto_show = true },
                list = {
                    selection = {
                        preselect = false,
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "markdown", "markdown_inline", "r", "rnoweb", "yaml", "latex", "csv",
            })

            -- Use the markdown parser for R Markdown and Quarto files
            vim.treesitter.language.register("markdown", { "rmd", "quarto" })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "markdown", "r", "rnoweb", "yaml", "tex", "csv", "rmd", "quarto" },
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
    },
    {
        "Vigemus/iron.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvimtools/none-ls-extras.nvim" },
    },
    {
        'nvim-mini/mini.statusline',
        version = '*',
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "R-nvim/R.nvim",
        -- Only required if you also set defaults.lazy = true
        lazy = false,
        -- R.nvim is still young and we may make some breaking changes from time
        -- to time (but also bug fixes all the time). If configuration stability
        -- is a high priority for you, pin to the latest minor version, but unpin
        -- it and try the latest version before reporting an issue:
        -- version = "~0.1.0"
        config = function()
            -- Create a table with the options to be passed to setup()
            ---@type RConfigUserOpts
            local opts = {
                hook = {
                    on_filetype = function()
                        vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                        vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                    end
                },
                R_args = { "--quiet", "--no-save" },
                min_editor_width = 72,
                rconsole_width = 78,
                objbr_mappings = { -- Object browser keymap
                    c = 'class',   -- Call R functions
                    -- Use {object} notation to write arbitrary R code.
                    ['<localleader>gg'] = 'head({object}, n = 15)',
                    v = function()
                        -- Run lua functions
                        require('r.browser').toggle_view()
                    end
                },
                disable_cmds = {
                    "RClearConsole",
                    "RCustomStart",
                    "RSPlot",
                    "RSaveClose",
                },
            }
            -- Check if the environment variable "R_AUTO_START" exists.
            -- If using fish shell, you could put in your config.fish:
            -- alias r "R_AUTO_START=true nvim"
            if vim.env.R_AUTO_START == "true" then
                opts.auto_start = "on startup"
                opts.objbr_auto_start = true
            end
            require("r").setup(opts)
        end,
    },
}
