return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = {    -- :h background
        light = "latte",
        dark = "mocha",
      },

      transparent_background = true, -- disables setting the background color.

      float = {
        transparent = true, -- enable transparent floating windows
        solid = true,       -- use solid styling for floating windows, see |winborder|
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
  end,
}
