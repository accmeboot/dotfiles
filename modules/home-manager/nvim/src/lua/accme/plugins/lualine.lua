return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = { left = "", right = "" },
				icons_enabled = true,
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = {
					{
						"filename",
						path = 1,
						shorting_target = 120,
					},
					"branch",
					"diff",
				},
				lualine_c = {
					"%=", --[[ add your center components here in place of this comment ]]
				},
				lualine_x = {},
				lualine_y = {
					{
						"filetype",
						colored = false,
					},
					"diagnostics",
					"progress",
				},
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},

			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
