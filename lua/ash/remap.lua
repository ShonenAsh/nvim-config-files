vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m' '<-2<CR>gv=gv") -- moves lines up
vim.keymap.set("v", "J", ":m' '>+1<CR>gv=gv") -- moves lines down

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keeps cursor centered when moving down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- keeps cursor centered when moving up

-- Keeps visual mode selection when changing indents
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without clearing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
-- TBD: Prevents pasting from replacing selection in visual mode
vim.keymap.set("v", "p", '"_dp', opts)

-- Delete selection without copying to clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- TBD: Exit insert mode with Ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Clear search highlights with Ctrl+c in normal mode
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = false})

-- Execute lsp formatter
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tw"," <cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>tn"," <cmd>tabn<CR>")
vim.keymap.set("n", "<leader>tp"," <cmd>tabp<CR>")

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically"})
vim.keymap.set("n", "<leader>sh", "<C-w>S", { desc = "Split window horizontally"})
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make window splits equal in size"})
vim.keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split"})


