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

-- fugitive colors remap for diff
local visual_hl = vim.api.nvim_get_hl(0, { name = "Visual" })
local search_hl = vim.api.nvim_get_hl(0, { name = "Search" })

if visual_hl.bg and search_hl.fg and search_hl.bg then
  local visual_bg = string.format("%06x", visual_hl.bg)
  local search_fg = string.format("%06x", search_hl.fg)
  local search_bg = string.format("%06x", search_hl.bg)

  vim.cmd("highlight DiffAdd guibg=#" .. visual_bg)
  vim.cmd("highlight DiffDelete guibg=#" .. visual_bg)
  vim.cmd("highlight DiffChange guibg=#" .. visual_bg)
  vim.cmd("highlight DiffText guibg=#" .. search_bg .. " guifg=#" .. search_fg)
end
