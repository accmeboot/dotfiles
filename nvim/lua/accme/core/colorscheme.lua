-- adding border to floating windows from LSP
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
	focus = true,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
	focus = true,
})

vim.diagnostic.config({
	float = { border = border, source = true, focus = true },
})

-- adding transparency to windows
vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
vim.cmd("highlight link NormalFloat Normal")
vim.cmd("highlight NormalFloat ctermbg=NONE guibg=NONE")
vim.cmd("highlight Pmenu ctermbg=NONE guibg=NONE")

-- fugitive colors remap for diff
local visual_bg = vim.api.nvim_get_hl_by_name("Visual", true)["background"]

local search_fg = vim.api.nvim_get_hl_by_name("Search", true)["foreground"]
local search_bg = vim.api.nvim_get_hl_by_name("Search", true)["background"]

if visual_bg and search_fg and search_bg then
	visual_bg = string.format("%x", visual_bg)
	search_fg = string.format("%x", search_fg)
	search_bg = string.format("%x", search_bg)

	vim.cmd("highlight DiffAdd guibg=#" .. visual_bg)
	vim.cmd("highlight DiffDelete guibg=#" .. visual_bg)
	vim.cmd("highlight DiffChange guibg=#" .. visual_bg)
	vim.cmd("highlight DiffText guibg=#" .. search_bg .. " guifg=#" .. search_fg)
end
