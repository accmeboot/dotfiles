{ pkgs, lib, ... }:
let
  deutils = pkgs.buildGoModule {
    pname = "deutils";
    version = "0.1.0";

    src = ./src/backend/deutils;

    vendorHash = "sha256-f444cTmN5WrgcFTvF2+cl98wc1ASpGH+2LCy0/81Up4=";

    meta = with lib; {
      description = "Desktop entry utilities for quickshell app launcher";
      license = licenses.mit;
    };
  };
in {
  programs.quickshell.enable = true;
  home.packages = with pkgs; [ kdePackages.qt5compat deutils ];
}
