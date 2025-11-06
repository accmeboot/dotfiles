vim.diagnostic.config({
  float = { border = "rounded", source = true, focusable = true },
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})

-- adding transparency to windows
vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
vim.cmd("highlight link NormalFloat Normal")
vim.cmd("highlight NormalFloat ctermbg=NONE guibg=NONE")
vim.cmd("highlight Pmenu ctermbg=NONE guibg=NONE")

-- adding transparency to status lines
local base_statusline_highlights = { 'StatusLine', 'StatusLineNC', 'Tabline', 'TabLineFill', 'Winbar',
  'WinbarNC' }
for _, hl_group in pairs(base_statusline_highlights) do
  vim.api.nvim_set_hl(0, hl_group, { bg = 'none' })
end

-- TSX/JSX specific treesitter highlighting improvements
vim.api.nvim_set_hl(0, '@tag', { link = 'Tag' })
vim.api.nvim_set_hl(0, '@tag.attribute', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@tag.delimiter', { link = 'Delimiter' })
vim.api.nvim_set_hl(0, '@constructor.tsx', { link = 'Type' })
vim.api.nvim_set_hl(0, '@tag.tsx', { link = 'Tag' })
vim.api.nvim_set_hl(0, '@tag.attribute.tsx', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@tag.builtin.tsx', { link = 'Special' })
vim.api.nvim_set_hl(0, '@variable.member.tsx', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@constructor.javascript', { link = 'Type' })
vim.api.nvim_set_hl(0, '@tag.javascript', { link = 'Tag' })
vim.api.nvim_set_hl(0, '@tag.attribute.javascript', { link = 'Identifier' })
