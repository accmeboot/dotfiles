return {
  -- this plugin uses terminal colors for colorscheme (now udnercurle, and some highlights improvements to make it transparent required
  "bjarneo/pixel.nvim",
  priority = 1000,
  enabled = false,
  config = function()
    vim.cmd.colorscheme("pixel")

    -- adding transparency
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'NonText', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'CursorLine',
      { bg = 'none', ctermbg = 'none', ctermfg = 'none', cterm = { underline = true } })
    vim.api.nvim_set_hl(0, 'CursorLineNr',
      { bg = 'none', ctermbg = 'none', ctermfg = 'none', cterm = { underline = true } })

    -- Fix fugitive diff highlights using terminal ANSI colors
    vim.api.nvim_set_hl(0, 'DiffAdd', { ctermfg = 7, ctermbg = 8, bold = true })
    vim.api.nvim_set_hl(0, 'DiffDelete', { ctermfg = 7, ctermbg = 8, bold = true })
    vim.api.nvim_set_hl(0, 'DiffChange', { ctermfg = 0, ctermbg = 4 })
    vim.api.nvim_set_hl(0, 'DiffText', { ctermfg = 7, ctermbg = 8, bold = true })


    -- Make telescope transparent
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = 'none', ctermbg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = 'none', ctermbg = 'none' })
  end,
}
