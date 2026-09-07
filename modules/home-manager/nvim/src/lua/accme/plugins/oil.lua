vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })

require("oil").setup({
	columns = { "icon" },
	keymaps = {
		["q"] = "actions.close",
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-k>"] = false,
		["<C-j>"] = false,
	},
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".git" or name == ".."
		end,
	},
	float = {
		padding = 12,
		max_width = math.floor(vim.api.nvim_win_get_width(0) / 1.5),
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		preview_split = "auto",
	},
})
