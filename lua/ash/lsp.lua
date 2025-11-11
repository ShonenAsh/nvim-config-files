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

vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go' },
})

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
})

vim.lsp.config('basedpyright', {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = true,
                },
                --                logLevel = 'Warning',
                typeCheckingMode = 'standard',
                diagnosticSeverityOverrides = {
                    reportUnusedImport = "none",
                    reportUnusedVariable = "none",
                },
            },
        },
    },
})

vim.lsp.config("ruff", {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    capabilities = {
        hoverProvider = false,
    },
})

vim.lsp.enable({ 'luals', 'gopls', 'basedpyright', 'clangd', 'ruff' })

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
        require 'none-ls.formatting.ruff_format',
        --        null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
    },
})

--
--vim.api.nvim_create_autocmd('LspAttach', {
--    callback = function(arg)
--        local client = vim.lsp.get_client_by_id(arg.data.client_id)
--        if client == nil then
--            return
--        end
--
--        if client.name == 'ruff' then
--            -- Disable hover in favor of Pyright
--            client.server_capabilities.hoverProvider = false
--        end
--
--        if client.name == 'basedpyright' then
--            -- Enable inlay hints
--            if client.supports_method('textDocument/inlayHint') then
--                vim.lsp.inlay_hint.enable(true, { bufnr = arg.buf })
--            end
--        end
--
--        if client:supports_method('textDocument/completion') then
--            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect',
--                'fuzzy', 'popup', 'preview' }
--            vim.lsp.completion.enable(true, client.id, arg.buf, { autotrigger = true })
--        end
--    end,
--})
--
--vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
--    vim.lsp.handlers.hover, { border = 'rounded' }
--)
--
--vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
--    vim.lsp.handlers.signature_help, { border = 'rounded' }
--)

vim.keymap.set('n', '<leader>td', function()
    local vlines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_lines = not vlines,
    })
end, { desc = 'Toggle diagnostics', silent = true, noremap = true })

vim.keymap.set('n', '<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = 'Toggle inlay hints' })
