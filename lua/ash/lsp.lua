vim.lsp.config('luals', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

-- node languages
-- vim.lsp.config('denols', {
--     cmd = { 'deno', 'lsp' },
--     filetypes = { 'javascript', 'typescript' },
--     root_markers = { 'package.json' }
-- })

vim.lsp.config('tsgo', {
  cmd = { 'tsc', '--lsp', '--stdio' },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
  root_dir = vim.fs.root(0, { 'tsconfig.json', 'package.json', '.git' }),
})

vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go' },
})

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = { 'compile_commands.json',
        'compile_flags.txt',
        'CMakeLists.txt',
        'Makefile',
        '.git'
    }
})

vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    settings = {
        ty = {
            diagnosticMode = 'workspace',
            experimental = {
                rename = true,
            },
        },
    },
})

-- Python formatter
vim.lsp.config("ruff", {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    capabilities = {
        hoverProvider = false,
    },
})

-- JS/TS
--vim.lsp.config('vtsls', {
--    cmd = { 'vtsls', '--stdio' },
--    filetypes = {
--        'javascript', 'javascriptreact', 'javascript.jsx',
--        'typescript', 'typescriptreact', 'typescript.tsx'
--    },
--    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
--    settings = {
--        typescript = {
--            inlayHints = {
--                parameterNames = { enabled = "all" },
--                variableTypes = { enabled = true },
--            },
--        },
--    },
--})
-- R language server
vim.lsp.config('r_language_server', {
    cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
    filetypes = { 'r', 'rmd' },
    root_markers = { '.Rprofile' },
})

vim.lsp.enable({ 'luals', 'gopls', 'ty', 'clangd', 'ruff', 'r_language_server', 'tsgo' })


local null_ls = require("null-ls")
-- 1. Grab the extras modules (requires 'nvim-lua/plenary.nvim' and 'nvim-tools/none-ls-extras.nvim')
local eslint_diagnostics = require("none-ls.diagnostics.eslint")
local eslint_code_actions = require("none-ls.code_actions.eslint")

null_ls.setup({
    sources = {
        require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
        require 'none-ls.formatting.ruff_format',
        -- ESLint Diagnostics (The modern way)
        eslint_diagnostics.with({

            condition = function(utils)
                return utils.root_has_file({

                    ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs"

                })
            end,
        }),

        -- ESLint Code Actions
        eslint_code_actions.with({
            condition = function(utils)
                return utils.root_has_file({
                    ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs"
                })
            end,
        }),
    }
})

vim.keymap.set('n', '<leader>td', function()
    local vlines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_lines = not vlines,
    })
end, { desc = 'Toggle diagnostics', silent = true, noremap = true })

vim.keymap.set('n', '<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = 'Toggle inlay hints' })

vim.cmd("set completeopt+=noselect")
