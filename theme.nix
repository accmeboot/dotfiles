{ pkgs, lib, ... }:
let
  schemeFile = pkgs.runCommand "scheme.json" { } ''
    ${pkgs.yj}/bin/yj -yj < ${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml > $out
  '';
  schemeData = builtins.fromJSON (builtins.readFile schemeFile);
  darkSchemeColors = builtins.mapAttrs (name: value: lib.removePrefix "#" value)
    schemeData.palette;

  mkBemenuOpts = { font, height, colors }:
    lib.concatStringsSep " " [
      "-p ❯"
      "-H ${toString height}"
      "--fn '${font.name} ${toString font.size}'"
      "--hp 8"
      "--cw 1"
      "--tf '#${colors.base05}'"
      "--tb '#${colors.base00}'"
      "--ff '#${colors.base05}'"
      "--fb '#${colors.base00}'"
      "--cf '#${colors.base05}'"
      "--cb '#${colors.base00}'"
      "--nf '#${colors.base05}'"
      "--nb '#${colors.base00}'"
      "--hf '#${colors.base00}'"
      "--hb '#${colors.base05}'"
      "--fbf '#${colors.base0D}'"
      "--fbb '#${colors.base00}'"
      "--sf '#${colors.base00}'"
      "--sb '#${colors.base05}'"
      "--af '#${colors.base05}'"
      "--ab '#${colors.base00}'"
    ];
in {
  darkScheme = {
    image = "${./assets/wallpapers/fire.png}";
    scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";
  };
  lightScheme = {
    image = "${./assets/wallpapers/fire.png}";
    scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
    polarity = "light";
  };

  inherit mkBemenuOpts;

  bemenuWrapper = pkgs.writeShellScript "bemenu-themed" ''
    exec ${pkgs.bemenu}/bin/bemenu ${
      mkBemenuOpts {
        font = {
          name = "Arimo Nerd Font";
          size = 12;
        };
        height = 25;
        colors = darkSchemeColors;
      }
    } "$@"
  '';
}
