{ pkgs, ... }: {
  home.packages = let
    dwm = pkgs.dwm.override {
      conf = ./config.def.h;
      patches = [
        # dwm patch name
      ];
    };
  in with pkgs; [ dwm ];

  home.file.".xinitrc" = {
    source = ./.xinitrc;
    executable = true;
  };
}

# gamescope -W 2560 -H 1440 --force-grab-cursor --adaptive-sync --force-composition -f -- %command%
