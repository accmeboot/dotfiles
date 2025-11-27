return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				nix = { "nixfmt" },
			},
			formatters = {
				prettier = {
					cwd = function(self, ctx)
						-- Try to find project root by looking for common root markers
						local root_markers = {
							".git",
							"package.json",
							".prettierrc",
							".prettierrc.js",
							".prettierrc.json",
							"prettier.config.js",
						}
						local root =
							vim.fs.dirname(vim.fs.find(root_markers, { upward = true, path = ctx.filename })[1])
						return root or vim.fn.getcwd()
					end,
				},
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		})
	end,
}
