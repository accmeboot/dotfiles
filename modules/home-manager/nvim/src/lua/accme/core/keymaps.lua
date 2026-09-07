local keymap = vim.keymap

-- nh for cleaning highlights after search
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- splitting windows
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>cs", ":close<CR>") -- close current split window

-- moving between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- save file --
keymap.set("n", "<leader>w", ":update<CR>")

keymap.set("n", "<S-l>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprev<CR>")

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

-- oil --
keymap.set("n", "<leader>e", ":Oil<CR>")

-- vim-fugitive --
local function toggle_fugitive()
	local bufnr = vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].buftype == "nowrite" then
		vim.api.nvim_command("tabc")
	else
		vim.api.nvim_command("tab G")
	end
end

keymap.set("n", "<leader>f", toggle_fugitive)

-- mini.pick --
keymap.set("n", "<leader>tf", MiniPick.builtin.files)
keymap.set("n", "<leader>ts", MiniPick.builtin.grep_live)
keymap.set("n", "<leader>tw", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end)
keymap.set("n", "<leader>tb", MiniPick.builtin.buffers)
keymap.set("n", "<leader>th", MiniPick.builtin.help)
keymap.set("n", "<leader>tr", MiniPick.builtin.resume)
keymap.set("n", "<leader>tc", MiniExtra.pickers.commands)

keymap.set("n", "<leader>tgb", MiniExtra.pickers.git_branches)
keymap.set("n", "<leader>tgc", MiniExtra.pickers.git_commits)

-- spell suggestion
keymap.set("n", "<leader>m", MiniExtra.pickers.spellsuggest)

-- mini.completion: popupmenu navigation
keymap.set("i", "<C-j>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true })

keymap.set("i", "<C-k>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true })

-- Confirm only an explicitly selected item, like nvim-cmp's `select = false`
keymap.set("i", "<CR>", function()
	local selected = vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1
	return selected and "<C-y>" or "<CR>"
end, { expr = true })

-- nvim-lint --
keymap.set("n", "<leader>l", function()
	require("lint").try_lint()
end, { desc = "Trigger linting for current file" })

-- LSP --
keymap.set("n", "gl", vim.diagnostic.open_float)
keymap.set("n", "<leader>RR", ":LspRestart<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("accme_lsp_attach", { clear = true }),
	callback = function(ev)
		local opts = { noremap = true, silent = true, buffer = ev.buf }

		keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
		keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				border = "rounded",
				max_width = 100,
				max_height = 15,
			})
		end, opts) -- show definition
		keymap.set("n", "gf", vim.lsp.buf.references, opts) -- show references
		keymap.set("n", "<leader>C", vim.lsp.buf.code_action, opts) -- code actions
		keymap.set("v", "<leader>R", vim.lsp.buf.rename, opts) -- rename everywhere
	end,
})
