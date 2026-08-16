return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_enable_italic = true
    vim.cmd.colorscheme("gruvbox-material")


    -- adding transparency to windows
    vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
    vim.cmd("highlight link NormalFloat Normal")
    vim.cmd("highlight NormalFloat ctermbg=NONE guibg=NONE")
    vim.cmd("highlight Pmenu ctermbg=NONE guibg=NONE")
  end,
}
