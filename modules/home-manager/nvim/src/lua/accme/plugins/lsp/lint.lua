return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		-- Configure eslint_d to use project root as cwd
		lint.linters.eslint_d = require("lint").linters.eslint_d
		lint.linters.eslint_d.cwd = function(params)
			-- Try to find project root by looking for common root markers
			local root_markers = { ".git", "package.json", ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
			local root = vim.fs.dirname(vim.fs.find(root_markers, { upward = true, path = params.bufname })[1])
			return root or vim.fn.getcwd()
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
