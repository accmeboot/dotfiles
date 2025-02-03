return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = { "branch", "diff" },
				lualine_c = {
					function()
						local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h") == "." and ""
							or vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
						local fname = vim.fn.expand("%:t") or ""

						-- If path is empty, just return filename with space
						if fpath == "" then
							return fname .. " "
						end

						-- Return both path and filename
						return string.format(" %%<%s/%s ", fpath, fname)
					end,
				},
				lualine_x = { "filetype" },
				lualine_y = { "diagnostics", "progress" },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
