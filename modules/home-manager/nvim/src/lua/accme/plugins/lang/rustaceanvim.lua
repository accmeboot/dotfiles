return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			tools = {},
			server = {
				default_settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
			dap = {},
		}
	end,
}
