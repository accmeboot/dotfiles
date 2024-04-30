return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = "verylazy",
  config = function()
    require("rose-pine").setup({
      variant = "auto",      -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = false,

      enable = {
        terminal = true,
        legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
        migrations = true,         -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    })

    -- vim.cmd("colorscheme rose-pine-main")

    -- recovering statusline colors when transparency is on
    -- vim.cmd("highlight Statusline guifg=#908caa guibg=#1f1d2e")
  end,
}
