return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local base16 = require("accme.local.base16")

    local colors, err = base16.get_colors_from_yaml_file(vim.fn.stdpath("config") .. "/colors.yaml")

    if not colors then
      vim.notify("Error reading YAML: " .. (err or "unknown error"), vim.log.levels.ERROR)
      return
    end

    require("cyberdream").setup({
      -- Set light or dark variant
      variant = "auto",
      transparent = true,

      -- Override colors
      colors = {
        bg = colors.base00,
        bg_alt = colors.base01,
        bg_highlight = colors.base02,
        fg = colors.base05,
        grey = colors.base03,
        blue = colors.base0D,
        green = colors.base0B,
        cyan = colors.base0C,
        red = colors.base08,
        yellow = colors.base0A,
        magenta = colors.base0F,

        -- Generate pink from base08 (red) by increasing blue
        pink = base16.get_pink(colors.base08),

        orange = colors.base09,
        purple = colors.base0E,
      },

      saturation = 0.5,

      highlights = {
        CursorLine = { bg = "NONE", underline = true },
        CursorLineNr = { bg = "NONE", underline = true },
      },
    })

    vim.cmd("colorscheme cyberdream")
  end
}
