{ config, lib, pkgs, ... }:
let 
  colorHash = builtins.substring 0 6 (builtins.hashString "md5" 
    "${config.theme.colors.base00}${config.theme.colors.base01}${config.theme.colors.base02}${config.theme.colors.base03}${config.theme.colors.base04}${config.theme.colors.base05}${config.theme.colors.base06}${config.theme.colors.base07}${config.theme.colors.base08}${config.theme.colors.base09}${config.theme.colors.base0A}${config.theme.colors.base0B}${config.theme.colors.base0C}${config.theme.colors.base0D}${config.theme.colors.base0E}${config.theme.colors.base0F}");
in
{
    home.file = {
      ".config/nvim/lua/accme/plugins/base16-${colorHash}.lua".text = ''
        return {
          "RRethy/base16-nvim",
            lazy = false,
            priority = 1000,
            config = function()
              local base16 = require("base16-colorscheme")

              base16.with_config({
                  telescope = false,
                  indentblankline = false,
                  notify = false,
                  ts_rainbow = false,
                  cmp = false,
                  illuminate = false,
                  dapui = false,
              })

              base16.setup({
                  base00 = "#${config.theme.colors.base00}",
                  base01 = "#${config.theme.colors.base01}",
                  base02 = "#${config.theme.colors.base02}",
                  base03 = "#${config.theme.colors.base03}",
                  base04 = "#${config.theme.colors.base04}",
                  base05 = "#${config.theme.colors.base05}",
                  base06 = "#${config.theme.colors.base06}",
                  base07 = "#${config.theme.colors.base07}",
                  base08 = "#${config.theme.colors.base08}",
                  base09 = "#${config.theme.colors.base09}",
                  base0A = "#${config.theme.colors.base0A}",
                  base0B = "#${config.theme.colors.base0B}",
                  base0C = "#${config.theme.colors.base0C}",
                  base0D = "#${config.theme.colors.base0D}",
                  base0E = "#${config.theme.colors.base0E}",
                  base0F = "#${config.theme.colors.base0F}",
              })
          end,
        }
      '';
    };
}
