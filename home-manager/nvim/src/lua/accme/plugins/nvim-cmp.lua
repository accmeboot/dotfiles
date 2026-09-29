vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
}, { confirm = false })

local cmp = require("cmp")

cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noselect",
	},
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			-- no snippets
			entry_filter = function(entry)
				return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
			end,
		},
		{ name = "buffer" },
		{ name = "path" },
	}),
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})
