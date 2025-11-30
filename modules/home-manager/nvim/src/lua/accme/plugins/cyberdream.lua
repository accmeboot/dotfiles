return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      -- Set light or dark variant
      variant = "auto",
      transparent = true,
      saturation = 0.5,

      highlights = {
        CursorLine = { bg = "NONE", underline = true },
        CursorLineNr = { bg = "NONE", underline = true },
      },
    })

    vim.cmd("colorscheme cyberdream")
  end
}
