return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- See https://github.com/Kotlin/kotlin-lsp/issues/217
		local servers = {
			"clangd",
			"cssls",
			"emmet_ls",
			"gopls",
			"html",
			"kotlin_language_server",
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
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		-- TODO: remove when kotlin-lsp updates
		vim.lsp.config("kotlin_language_server", {
			before_init = function(params)
				if not next(params.initializationOptions or {}) then
					params.initializationOptions = vim.empty_dict()
				end
			end,
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
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

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("accme_lsp_attach", { clear = true }),
			callback = function(ev)
				local opts = { noremap = true, silent = true, buffer = ev.buf }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({
						border = "rounded",
						max_width = 100,
						max_height = 15,
					})
				end, opts) -- show definition
				vim.keymap.set("n", "gf", vim.lsp.buf.references, opts) -- show references
				vim.keymap.set("n", "<leader>C", vim.lsp.buf.code_action, opts) -- code actions
				vim.keymap.set("v", "<leader>R", vim.lsp.buf.rename, opts) -- rename everywhere
			end,
		})
	end,
}
