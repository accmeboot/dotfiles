return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"mrcjkb/rustaceanvim",
			version = "^4", -- Recommended
			ft = { "rust" },
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		local on_attach = function(client, bufnr)
			-- Prevent duplicate ts_ls or emmet_ls
			local existing_clients = vim.lsp.get_active_clients({ bufnr = bufnr })

			for _, existing in ipairs(existing_clients) do
				if existing.name == client.name and existing.id ~= client.id then
					vim.notify("Stopping duplicate LSP client: " .. client.name)
					client.stop()
					return
				end
			end

			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- set keybinds
			keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
			keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, opts) -- show definition
			keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- show references
			keymap.set("n", "<leader>C", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- show references
			keymap.set("v", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- rename everywhere
			keymap.set("n", "gr", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- show diagnostic
			keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
			keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- LSP config is the same + capabilities
		vim.g.rustaceanvim = {
			tools = {},
			server = {
				on_attach = on_attach,
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

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetype = { "html", "tmpl", "gotmpl" },
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "gopls", "--remote=auto" },
		})

		lspconfig["sqlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.mdx_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
			end,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.diagnostic.config({
			virtual_text = {
				prefix = "",
				spacing = 4,
			},
		})
	end,
}
