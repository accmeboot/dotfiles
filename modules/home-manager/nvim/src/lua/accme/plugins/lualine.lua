return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    local transparent_auto_theme = require('lualine.themes.auto')

    transparent_auto_theme.normal.c.bg = 'None'

    require("lualine").setup({
      options = {
        theme = transparent_auto_theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          { "branch", icon = "", padding = { left = 1 }, color = "StatusLine", },
          { "diff", color = { bg = "None" }, },
        },
        lualine_c = {
          { "filename", icon = "", path = 3, color = "StatusLine" },
        },
        lualine_x = {
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then
                return ""
              else
                return "recording @" .. reg
              end
            end,
            color = "WarningMsg",
          },
        },
        lualine_y = {
          {
            "filetype",
            colored = false,
            icon_only = true,
            color = "StatusLine"
          },
          { "diagnostics", color = { bg = "None" } },
          { "location",    color = "StatusLine",   padding = { right = 0 } },
        },
        lualine_z = {
          { "progress", color = "StatusLine" },
        },
      },
    })
  end,
}
