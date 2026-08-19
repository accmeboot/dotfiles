{ pkgs, config, lib, ... }:
let
  theme = import ../../../theme.nix { inherit pkgs lib; };
  stylixColors = config.lib.stylix.colors;
  bemenuOpts = theme.mkBemenuOpts {
    font = {
      name = config.stylix.fonts.sansSerif.name;
      size = config.stylix.fonts.sizes.popups;
    };
    height = config.stylix.fonts.sizes.popups + 13;
    colors = stylixColors;
  };
in {
  options.programs.bemenu.opts = lib.mkOption {
    type = lib.types.str;
    default = bemenuOpts;
    readOnly = true;
  };

  config = {
    home.packages = with pkgs; [ bemenu ];
    home.sessionVariables = { BEMENU_OPTS = bemenuOpts; };
    systemd.user.sessionVariables = { BEMENU_OPTS = bemenuOpts; };
  };
}
