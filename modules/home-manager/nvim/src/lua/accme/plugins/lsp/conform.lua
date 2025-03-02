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
				markdown = function(bufnr)
					-- TODO: this is temp fix for MDX storybook files, mdx_analyzer lsp doesn't work
					-- if vim.bo[bufnr].filetype == "markdown" then
					-- 	return { "prettier" }
					-- end

					return {}
				end,
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		})
	end,
}
