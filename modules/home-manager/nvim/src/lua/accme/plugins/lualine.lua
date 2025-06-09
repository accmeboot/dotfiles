return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          {
            function()
              return require("accme.local.codecompanion-spinner").get_lualine_status()
            end,
            color = "WarningMsg",
          },
          { "branch", icon = "", color = "StatusLine", padding = { left = 1 } },
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

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
