vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/mason-org/mason.nvim",
}, { confirm = false })

require("mason").setup({
	ui = {
		border = "rounded",
	},
})

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	automatic_enable = false,
})

local registry = require("mason-registry")
local to_package = mason_lspconfig.get_mappings().lspconfig_to_package

local nix_provided = {
	["nil"] = true,
	["rust-analyzer"] = true,
}

local function packages_for(ft)
	local wanted = {}

	for _, server in ipairs(mason_lspconfig.get_available_servers({ filetype = ft })) do
		if vim.lsp.is_enabled(server) and to_package[server] then
			wanted[to_package[server]] = true
		end
	end

	local conform = package.loaded["conform"]
	if conform then
		for _, formatter in ipairs(conform.formatters_by_ft[ft] or {}) do
			if type(formatter) == "string" then
				wanted[formatter] = true
			end
		end
	end

	local lint = package.loaded["lint"]
	if lint then
		for _, linter in ipairs(lint.linters_by_ft[ft] or {}) do
			wanted[linter] = true
		end
	end

	return vim.tbl_keys(wanted)
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("accme_mason_install", { clear = true }),
	callback = function(ev)
		for _, name in ipairs(packages_for(ev.match)) do
			if not nix_provided[name] and registry.has_package(name) then
				local package = registry.get_package(name)
				if not package:is_installed() then
					vim.notify(("mason: installing %s"):format(name))
					package:install()
				end
			end
		end
	end,
})
