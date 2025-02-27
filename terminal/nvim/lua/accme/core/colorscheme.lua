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

-- diagnostic colors remap
local error_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg
local hint_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg
local info_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg
local warn_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg

local diagnostic_bg = vim.g.base16_gui02

if error_fg and hint_fg and info_fg and warn_fg then
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = error_fg, bg = diagnostic_bg })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = hint_fg, bg = diagnostic_bg })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = info_fg, bg = diagnostic_bg })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = warn_fg, bg = diagnostic_bg })

	vim.api.nvim_set_hl(
		0,
		"DiagnosticUnderlineError",
		{ undercurl = true, sp = error_fg, cterm = { undercurl = true } }
	)
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = hint_fg, cterm = { undercurl = true } })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = info_fg, cterm = { undercurl = true } })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = warn_fg, cterm = { undercurl = true } })
end

-- Make statusline transparent
vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")

-- Settings for gutter colors
local bg_color = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
if bg_color then
	-- Convert to hex and darken by ~3%
	local darker_bg = string.format("#%06x", bit.band(bg_color - 0x090909, 0xFFFFFF))
	-- Set the SignColumn and LineNr background to the darker color
	vim.api.nvim_set_hl(0, "SignColumn", { bg = darker_bg })
	vim.api.nvim_set_hl(0, "LineNr", { bg = darker_bg })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = darker_bg })

	-- Get and preserve diagnostic colors
	local diagnostic_signs = {
		"DiagnosticSignError",
		"DiagnosticSignWarn",
		"DiagnosticSignInfo",
		"DiagnosticSignHint",
	}

	for _, sign in ipairs(diagnostic_signs) do
		local original = vim.api.nvim_get_hl(0, { name = sign, link = false })
		if original.fg then
			vim.api.nvim_set_hl(0, sign, {
				fg = original.fg,
				bg = darker_bg,
			})
		end
	end
end
