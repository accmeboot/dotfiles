return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	opts = {
		provider = "openai", -- openai
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
		},
		openai = {
			endpoint = "https://api.openai.com/v1",
			model = "gpt-4.1", -- your desired model (or use gpt-4o, etc.)
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			temperature = 0,
			max_completion_tokens = 10000, -- Increase this to include reasoning tokens (for reasoning models)
		},
		hints = { enabled = false },
		windows = {
			width = 35, -- default % based on available width
			sidebar_header = {
				enabled = true, -- true, false to enable/disable the header
			},
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"MunifTanjim/nui.nvim",
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
				code = {
					disable_background = true,
					style = "normal",
				},
			},
			ft = { "markdown", "Avante" },
		},
	},
	config = function(_, opts)
		require("avante").setup(opts)

		vim.o.laststatus = 3 -- views can only be fully collapsed with the global statusline
	end,
}
