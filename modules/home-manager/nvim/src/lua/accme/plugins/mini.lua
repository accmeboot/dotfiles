vim.pack.add({ "https://github.com/echasnovski/mini.nvim" }, { confirm = false })

require("mini.icons").setup()

MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()

local hipatterns = require("mini.hipatterns")

hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("mini.comment").setup()
require("mini.statusline").setup()

vim.env.RIPGREP_CONFIG_PATH = vim.fs.joinpath(vim.fn.stdpath("config"), "ripgreprc")

local pick = require("mini.pick")

require("mini.extra").setup()

pick.setup({
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
	},
	window = {
		config = function()
			local height = math.floor(0.3 * vim.o.lines)
			local width = math.floor(0.5 * vim.o.columns)

			return {
				border = "rounded",
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
})

require("mini.completion").setup({
	window = {
		info = { border = "rounded" },
		signature = { border = "rounded" },
	},
})
