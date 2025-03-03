return {
	"https://github.com/tpope/vim-fugitive",
	config = function()
		local function toggle_fugitive()
			local bufnr = vim.api.nvim_get_current_buf()
			local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")

			if buftype == "nowrite" then
				-- fugitive window is open, close the tab
				vim.api.nvim_command("tabc")
			else
				-- fugitive window is not open, open it in a new tab
				vim.api.nvim_command("tab G")
			end
		end

		vim.keymap.set("n", "<leader>f", toggle_fugitive)
	end,
}
