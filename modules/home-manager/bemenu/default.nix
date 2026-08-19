{ pkgs, config, lib, ... }:
let
  stylixColors = config.lib.stylix.colors;
  bemenuOpts = lib.concatStringsSep " " [
    "-p ❯"
    "-H ${toString (config.stylix.fonts.sizes.popups + 13)}"
    "--fn ${config.stylix.fonts.sansSerif.name} ${
      toString config.stylix.fonts.sizes.popups
    }"
    "--hp 8"
    "--cw 1"
    "--tf '#${stylixColors.base05}'"
    "--tb '#${stylixColors.base00}'"
    "--ff '#${stylixColors.base05}'"
    "--fb '#${stylixColors.base00}'"
    "--cf '#${stylixColors.base05}'"
    "--cb '#${stylixColors.base00}'"
    "--nf '#${stylixColors.base05}'"
    "--nb '#${stylixColors.base00}'"
    "--hf '#${stylixColors.base00}'"
    "--hb '#${stylixColors.base05}'"
    "--fbf '#${stylixColors.base0D}'"
    "--fbb '#${stylixColors.base00}'"
    "--sf '#${stylixColors.base00}'"
    "--sb '#${stylixColors.base05}'"
    "--af '#${stylixColors.base05}'"
    "--ab '#${stylixColors.base00}'"
  ];
in {
  options.programs.bemenu.opts = lib.mkOption {
    type = lib.types.str;
    default = bemenuOpts;
    readOnly = true;
  };

  config = {
    home.packages = with pkgs; [ bemenu ];
    home.sessionVariables = { BEMENU_OPTS = bemenuOpts; };
  };
}
