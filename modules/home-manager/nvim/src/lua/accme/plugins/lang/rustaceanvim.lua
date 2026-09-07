vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^4") },
}, { confirm = false })

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
