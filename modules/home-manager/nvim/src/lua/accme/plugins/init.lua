return {
  "https://github.com/christoomey/vim-tmux-navigator",
  "nvim-tree/nvim-web-devicons",
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        disable_background = true,
        style = "normal",
      },
      heading = {
        backgrounds = {
          'NONE',
          'NONE',
          'NONE',
          'NONE',
          'NONE',
          'NONE',
        },
      },
    },
  },
  "nvim-lua/plenary.nvim",
}
