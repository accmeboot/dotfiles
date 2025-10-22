return {
  "rose-pine/neovim",
  name = "rose-pine",
  enabled = true,
  config = function()
    require("rose-pine").setup({
      variant = "auto",      -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      extend_background_behind_borders = false,
      styles = {
        transparency = true,
      },

    })

    vim.cmd("colorscheme rose-pine")
  end
}
