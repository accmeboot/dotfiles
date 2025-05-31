return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, padding = { left = 0, right = 1 } } },
        lualine_b = {
          { "branch", icon = "" },
          "diff",
        },
        lualine_c = {
          { "filename", icon = "", path = 3 },
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
            color = "WarningMsg"
          },
        },
        lualine_y = {
          {
            "filetype",
            colored = false,
            icon_only = true,
            padding = 0,
          },
          "diagnostics",
          "progress",
        },
        lualine_z = {
          { "location", separator = { right = "" }, padding = { left = 1, right = 0 } },
        },
      },

      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
