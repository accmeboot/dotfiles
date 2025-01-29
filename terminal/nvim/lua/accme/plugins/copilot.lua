return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = { "zbirenbaum/copilot.lua" },
	branch = "main",
	config = function()
		local chat = require("CopilotChat")

		chat.setup({
			show_help = false, -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
			language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
				width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
			},
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<C-c>",
				},
			},
			model = "claude-3.5-sonnet",
		})

		local function open_h_split()
			chat.toggle({
				window = {
					layout = "float",
				},
			})
		end

		vim.keymap.set("n", "<leader>cb", ":CopilotChatToggle<CR>")
		vim.keymap.set("v", "<leader>cb", ":<C-U>CopilotChatToggle<CR>")
		vim.keymap.set("n", "<leader>cf", open_h_split)
		vim.keymap.set("v", "<leader>cf", open_h_split)
	end,
}
