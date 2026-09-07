vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/andymass/vim-matchup",
}, { confirm = false })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)

		if not vim.treesitter.language.add(lang) then
			local available = vim.g.ts_available or require("nvim-treesitter").get_available()
			if not vim.g.ts_available then
				vim.g.ts_available = available
			end
			if vim.tbl_contains(available, lang) then
				require("nvim-treesitter").install(lang)
			end
		end

		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})

require("nvim-ts-autotag").setup({})
