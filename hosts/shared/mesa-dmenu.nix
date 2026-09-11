{ pkgs, lib }:
pkgs.writeShellApplication {
  name = "mesa-dmenu";
  runtimeInputs = with pkgs; [ socat coreutils ];
  text = lib.removePrefix ''
    #!/bin/sh
  '' (builtins.readFile ../../scripts/mesa-dmenu.sh);
}
