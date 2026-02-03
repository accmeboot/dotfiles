{ pkgs, ... }: {
  home.packages = let
    dwm = pkgs.dwm.override {
      conf = ./config.def.h;
      patches = [
        # dwm patch name
        ./patches/dwm-titlecolor-20210815-ed3ab6b4.diff
        ./patches/dwm-alpha-20250918-74edc27.diff
        ./patches/dwm-statuspadding-6.3.diff
        ./patches/dwm-alwayscenter-20200625-f04cac6.diff
        ./patches/dwm-actualfullscreen-20211013-cb3f58a.diff
      ];
    };
  in with pkgs; [ dwm ];

  home.file.".xinitrc" = {
    source = ./.xinitrc;
    executable = true;
  };
}

# gamescope -W 2560 -H 1440 --force-grab-cursor --adaptive-sync --force-composition -f -- %command%
