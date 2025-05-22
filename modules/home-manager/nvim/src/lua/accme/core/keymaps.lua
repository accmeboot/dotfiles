vim.g.mapleader = " "

local keymap = vim.keymap

-- nh for cleaning highlights after search
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- splitting windows
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sc", ":close<CR>") -- close current split window

-- save file --
keymap.set("n", "<leader>w", ":update<CR>")

keymap.set("n", "<S-l>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprev<CR>")

keymap.set("n", "<leader>RR", ":LspRestart<CR>")

-- close buffer
keymap.set("n", "<leader>q", ":bd<cr>")

-- moving selection
keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv")
keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv")

-- resize split windows
keymap.set("n", "<leader>]", ":vertical resize -5<CR>")
keymap.set("n", "<leader>[", ":vertical resize +5<CR>")
keymap.set("n", "<leader>{", ":resize -5<CR>")
keymap.set("n", "<leader>}", ":resize +5<CR>")

-- Preserve the copied value
keymap.set("x", "<leader>p", '"_dP')

-- spell suggestion
keymap.set("n", "<leader>m", ":SpellSuggest<CR>")

keymap.set("n", "<leader>e", ":Oil<CR>")

-- LSP
keymap.set("n", "gl", vim.diagnostic.open_float)
