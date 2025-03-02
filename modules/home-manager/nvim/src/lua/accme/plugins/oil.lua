return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["q"] = "actions.close",
					--   ["<C-h>"] = false,
					--   ["<C-l>"] = false,
					--   ["<C-k>"] = false,
					--   ["<C-j>"] = false,
					--   ["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						return name == ".git" or name == ".."
					end,
				},
				float = {
					-- Padding around the floating window
					padding = 12,
					max_width = math.floor(vim.api.nvim_win_get_width(0) / 1.5),
					max_height = 0,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					-- preview_split: Split direction: "auto", "left", "right", "above", "below".
					preview_split = "auto",
				},
			})

			-- Open parent directory in current window
			-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			-- Open parent directory in floating window
			-- vim.keymap.set("n", "<space>-", require("oil").toggle_float)
		end,
	},
}
