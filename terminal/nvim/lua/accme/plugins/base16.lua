return {
	"https://github.com/RRethy/base16-nvim",
	config = function()
		local base16 = require("base16-colorscheme")

		base16.with_config({
			telescope = false,
			indentblankline = false,
			notify = false,
			ts_rainbow = false,
			cmp = false,
			illuminate = false,
			dapui = false,
		})

		base16.setup({
			base00 = "#1C1917",
			base01 = "#2D2927",
			base02 = "#3E3937",
			base03 = "#756E6B",
			base04 = "#988F8C",
			base05 = "#CBC6C1", -- Softened from DBD6D1
			base06 = "#DCD7D2", -- Softened from ECE7E2
			base07 = "#EAE5E0", -- Softened from FAF5F0
			base08 = "#C5907B",
			base09 = "#C4B187",
			base0A = "#D7C897",
			base0B = "#B8C196",
			base0C = "#A699B7",
			base0D = "#9F8B96",
			base0E = "#B8B0A4",
			base0F = "#7B9F7B",
		})
	end,
}
