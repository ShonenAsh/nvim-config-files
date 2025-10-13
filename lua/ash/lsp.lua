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
        pyright = {

            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})

vim.lsp.enable({ 'luals', 'gopls', 'basedpyright', 'clangd' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(arg)
        local client = vim.lsp.get_client_by_id(arg.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect',
                'fuzzy', 'popup', 'preview' }
            vim.lsp.completion.enable(true, client.id, arg.buf, { autotrigger = true })
        end
    end,
})

--local ns = vim.api.nvim_create_namespace("lsp_diagnostics")
--local org_signs_handler = vim.diagnostic.handlers.signs
--vim.diagnostic.handlers.signs = {
--    show = function(namespace, bufnr, diagnostics, opts)
--        local diag = vim.diagnostic.get(bufnr)
--        local max_severity_per_line = {}
--        for _, d in pairs(diag) do
--            local m = max_severity_per_line[d.lnum]
--            if not m or d.severity < m.severity then
--                max_severity_per_line[d.lnum] = d
--            end
--        end
--        local filtered_diag = vim.tbl_values(max_severity_per_line)
--        org_signs_handler.show(ns, bufnr, filtered_diag, opts)
--    end,
--    hide = function(_, bufnr)
--        org_signs_handler.hide(ns, bufnr)
--    end,
--}

--vim.diagnostic.config({
--    virtual_text = {
--        severity = nil,
--        source = "if_many",
--    },
--    signs = true,
--    underline = true,
--    severity_sort = true,
--    float = {
--        header = false,
--        border = 'rounded',
--        focusable = true,
--        source = true,
--    },
--})

vim.keymap.set('n', '<leader>td', function()
    vim.diagnostic.config({
        virtual_lines = {
            current_line = true,
        },
        virtual_text = false
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
        group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
        callback = function()
            vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
            return true
        end,
    })
end)

