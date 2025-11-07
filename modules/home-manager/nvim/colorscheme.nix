{ config, lib, ... }:
let
  colorHash = builtins.substring 0 6 (builtins.hashString "md5"
    "${config.theme.colors.base00}${config.theme.colors.base01}${config.theme.colors.base02}${config.theme.colors.base03}${config.theme.colors.base04}${config.theme.colors.base05}${config.theme.colors.base06}${config.theme.colors.base07}${config.theme.colors.base08}${config.theme.colors.base09}${config.theme.colors.base0A}${config.theme.colors.base0B}${config.theme.colors.base0C}${config.theme.colors.base0D}${config.theme.colors.base0E}${config.theme.colors.base0F}");

  # Helper function to parse hex digit to int
  hexToInt = hex:
    let
      digits = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
      };
    in digits.${hex};

  # Parse two hex digits to int (0-255)
  parseHexByte = str:
    let
      high = hexToInt (builtins.substring 0 1 str);
      low = hexToInt (builtins.substring 1 1 str);
    in high * 16 + low;

  # Convert int to two-digit hex string
  intToHex = val:
    let
      digits =
        [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f" ];
      high = builtins.elemAt digits (val / 16);
      low = builtins.elemAt digits (lib.mod val 16);
    in high + low;

  # Helper function to adjust color brightness
  adjustBrightness = color: factor:
    let
      # Remove # if present
      cleanColor = lib.removePrefix "#" color;
      # Parse RGB components
      r = parseHexByte (builtins.substring 0 2 cleanColor);
      g = parseHexByte (builtins.substring 2 2 cleanColor);
      b = parseHexByte (builtins.substring 4 2 cleanColor);
      # Adjust brightness (clamp to 0-255)
      adjust = val:
        let result = builtins.floor (val * factor);
        in lib.min 255 (lib.max 0 result);
      r' = adjust r;
      g' = adjust g;
      b' = adjust b;
    in intToHex r' + intToHex g' + intToHex b';

  # Create color variants from base0E (purple/magenta)
  magentaColor = adjustBrightness config.theme.colors.base0E 1.0; # Original
  pinkColor =
    adjustBrightness config.theme.colors.base0E 1.15; # Lighter (more pink)
  purpleColor =
    adjustBrightness config.theme.colors.base0E 0.85; # Darker (more purple)
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
                magenta = "#${magentaColor}",
                pink = "#${pinkColor}",
                orange = "#${config.theme.colors.base09}",
                purple = "#${purpleColor}",
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
