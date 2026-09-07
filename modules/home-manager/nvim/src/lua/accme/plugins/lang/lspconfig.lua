vim.pack.add({
	"https://github.com/antosha417/nvim-lsp-file-operations",
	"https://github.com/neovim/nvim-lspconfig",
}, { confirm = false })

require("lsp-file-operations").setup()

local servers = {
	"clangd",
	"cssls",
	"emmet_ls",
	"gopls",
	"html",
	"lua_ls",
	"mdx_analyzer",
	"nil_ls",
	"pyright",
	"qmlls",
	"sqlls",
	"svelte",
	"tailwindcss",
	"ts_ls",
}

vim.lsp.config("*", {
	capabilities = require("mini.completion").get_lsp_capabilities(),
})

vim.lsp.enable(servers)

require("mason-registry"):on("package:install:success", function()
	vim.schedule(function()
		vim.lsp.enable(servers)
	end)
end)

vim.diagnostic.config({
	float = { border = "rounded", source = true, focusable = true },
	virtual_lines = false,
})
