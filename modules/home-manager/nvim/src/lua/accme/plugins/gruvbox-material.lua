return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_transparent_background = 2
    vim.g.gruvbox_material_foreground = "original"

    vim.cmd.colorscheme("gruvbox-material")
  end,
}
