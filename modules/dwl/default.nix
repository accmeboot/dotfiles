{ pkgs, ... }:
{
  programs.dwl = {
    enable = true;
    package = 
      (pkgs.dwl.override {
        configH = ./src/config.def.h;
      }).overrideAttrs (oldAttrs: {
        buildInputs =
          oldAttrs.buildInputs or []
          ++ [
            pkgs.libdrm
            pkgs.fcft
          ];
        patches = oldAttrs.patches or [] ++ [
          ./src/patches/bar-0.7.patch
          ./src/patches/autostart-0.7.patch
          ./src/patches/gaps.patch
        ];
      });
  };
}
