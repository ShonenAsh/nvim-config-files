vim.lsp.config('luals', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})

vim.lsp.config('gopls', {
    cmd = {'gopls'},
    filetypes = {'go'},
})

vim.lsp.config('basedpyright', {
    cmd = {'basedpyright-langserver', '--stdio'},
    filetypes = {'python'},
})

vim.lsp.enable({'luals', 'gopls', 'basedpyright'})

-- TODO: find out why this shit is needed 
-- (No select to completeopt, otherwise autocompletion is annoying apparently)
-- vim.cmd("set completeopt+=noselect")

vim.o.winborder = 'rounded'

