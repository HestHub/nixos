-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Map = vim.keymap.set
--
Map({ "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save File" })
Map({ "n", "v" }, "d", '"_d')
Map("n", "c", '"_c', {})
Map("n", "<leader>U", require("undotree").toggle, { noremap = true, silent = true, desc = "Open UndoTree" })

-- Move selection
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")

-- switch buffer
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")

-- Move down and center view
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")

-- find and center
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- scrolling
Map("n", ",", "<C-u>", { noremap = true, silent = true })
Map("n", "m", "<C-d>", { noremap = true, silent = true })
Map("n", "M", "m", { noremap = true, silent = true })

-- Insert empty line without entering insert mode
Map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
Map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })
