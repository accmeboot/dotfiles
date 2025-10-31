vim.diagnostic.config({
  float = { border = "rounded", source = true, focusable = true },
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = false,
  },
})

-- adding transparency to windows
vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
vim.cmd("highlight link NormalFloat Normal")
vim.cmd("highlight NormalFloat ctermbg=NONE guibg=NONE")
vim.cmd("highlight Pmenu ctermbg=NONE guibg=NONE")

vim.cmd('highlight CursorLine cterm=underline gui=underline ctermbg=NONE guibg=NONE')
vim.cmd('highlight CursorLineNr ctermbg=NONE guibg=NONE')

-- local base_statusline_highlights = { 'StatusLine', 'StatusLineNC', 'Tabline', 'TabLineFill', 'Winbar',
--   'WinbarNC' }
-- for _, hl_group in pairs(base_statusline_highlights) do
--   vim.api.nvim_set_hl(0, hl_group, { bg = 'none' })
-- end
