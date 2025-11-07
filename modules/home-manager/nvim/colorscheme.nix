{ config, ... }:
let
  colorHash = builtins.substring 0 6 (builtins.hashString "md5"
    "${config.theme.colors.base00}${config.theme.colors.base01}${config.theme.colors.base02}${config.theme.colors.base03}${config.theme.colors.base04}${config.theme.colors.base05}${config.theme.colors.base06}${config.theme.colors.base07}${config.theme.colors.base08}${config.theme.colors.base09}${config.theme.colors.base0A}${config.theme.colors.base0B}${config.theme.colors.base0C}${config.theme.colors.base0D}${config.theme.colors.base0E}${config.theme.colors.base0F}");
in {
  home.file = {
    ".config/nvim/lua/accme/plugins/base16-${colorHash}.lua".text = ''
      return {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require("cyberdream").setup({
            -- Set light or dark variant
            variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

            -- Enable transparent background
            transparent = true,

            -- Reduce the overall saturation of colours for a more muted look
            saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)

            -- Override colors
            colors = {
                -- For a list of colors see `lua/cyberdream/colours.lua`

                -- Override colors for both light and dark variants
                bg = "#${config.theme.colors.base00}",
                bg_alt = "#${config.theme.colors.base01}",
                bg_highlight = "#${config.theme.colors.base02}",
                fg = "#${config.theme.colors.base05}",
                grey = "#${config.theme.colors.base03}",
                blue = "#${config.theme.colors.base0D}",
                green = "#${config.theme.colors.base0B}",
                cyan = "#${config.theme.colors.base0C}",
                red = "#${config.theme.colors.base08}",
                yellow = "#${config.theme.colors.base0A}",
                magenta = "#${config.theme.colors.base0F}",
                pink = "#${config.theme.colors.base0E}",
                orange = "#${config.theme.colors.base09}",
                purple = "#${config.theme.colors.base07}",
            },
          })

          vim.api.nvim_create_autocmd('ColorScheme', {
            command = [[
              highlight CursorLine guibg=NONE cterm=underline
              highlight CursorLineNr guibg=NONE cterm=underline
            ]]
          })

          vim.cmd("colorscheme cyberdream")
        end
      }
    '';
  };
}
