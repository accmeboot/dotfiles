vim.pack.add({ "https://github.com/folke/lazydev.nvim" }, { confirm = false })

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})
