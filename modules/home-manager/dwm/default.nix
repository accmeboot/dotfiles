{ config, pkgs, ... }:
{
  # Create custom DWM package using your existing config.h
  home.packages = [
    (pkgs.dwm.overrideAttrs (oldAttrs: {
      src = pkgs.fetchgit {
        url = "https://git.suckless.org/dwm";
        rev = "HEAD";
        sha256 = "sha256-unlg4vhpVwA+HV/qtzPAJjiXvDgG8hgL56NqmpRid3k=";
      };

      patches = [
        ./patches/dwm-systray.diff
        ./patches/full-gaps.diff
        ./patches/fix-borders.diff
      ];

      postPatch = ''
        # Copy your custom config.def.h
        cp ${./src/config.def.h} config.def.h
        
        # Replace color variable definitions with theme colors
        sed -i 's/static const char col_gray1\[\].*$/static const char col_gray1[]       = "#${config.theme.colors.base00}";/' config.def.h
        sed -i 's/static const char col_gray2\[\].*$/static const char col_gray2[]       = "#${config.theme.colors.base01}";/' config.def.h
        sed -i 's/static const char col_gray3\[\].*$/static const char col_gray3[]       = "#${config.theme.colors.base05}";/' config.def.h
        sed -i 's/static const char col_gray4\[\].*$/static const char col_gray4[]       = "#${config.theme.colors.base00}";/' config.def.h
        sed -i 's/static const char col_cyan\[\].*$/static const char col_cyan[]        = "#${config.theme.colors.base0D}";/' config.def.h


        # Replace border width with theme value
        sed -i 's/static const unsigned int borderpx.*$/static const unsigned int borderpx  = ${toString config.theme.borderWidth};        \/\* border pixel of windows \*\//' config.def.h


        # Replace gaps width with theme value
        sed -i 's/static const unsigned int gappx.*$/static const unsigned int gappx = ${toString config.theme.spacing.s};        \/\* gaps between windows \*\//' config.def.h
      '';
    }))
  ];


  # Create xinitrc file
  home.file.".xinitrc" = {
    source = ./src/.xinitrc;
    executable = true;
  };
}
