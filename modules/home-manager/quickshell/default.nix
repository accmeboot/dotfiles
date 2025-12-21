{ pkgs, lib, ... }:
let
  deutils = pkgs.buildGoModule {
    pname = "deutils";
    version = "0.1.0";

    src = ./src/backend/deutils;

    vendorHash = "sha256-EyBaDT8Mco/+R7A+F6oeJCBRbJNvtcIaCzNEXHwsNZY=";

    goSum = ./src/backend/deutils/go.sum;

    meta = with lib; {
      description = "Desktop entry utilities for quickshell app launcher";
      license = licenses.mit;
    };
  };
in {
  programs.quickshell.enable = true;
  home.packages = with pkgs; [
    kdePackages.qt5compat
    deutils
    kdePackages.qtdeclarative
  ];
}
