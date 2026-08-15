return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  config = function()
    require("cyberdream").setup({
      variant = "auto",
      transparent = true,

      highlights = {
        CursorLine = { bg = "NONE", underline = true },
        CursorLineNr = { bg = "NONE", underline = true },
      },
    })

    vim.cmd("colorscheme cyberdream")
  end
}
