{ pkgs, lib }:
let
  adaptSchemeToWallpaper = { scheme, wallpaperPath }:
    let
      # Write scheme to JSON
      schemeJson = pkgs.writeText "scheme.json" (builtins.toJSON scheme);

      # Python script with dependencies
      pythonWithDeps = pkgs.python3.withPackages (ps: [ ps.pillow ps.numpy ]);

      # Run Python script to adapt colors
      result = import (pkgs.runCommand "adapted-scheme.nix" { } ''
        ${pythonWithDeps}/bin/python3 ${./adapt_colors.py} \
          ${schemeJson} \
          ${wallpaperPath} > $out
      '');
    in result;

in {
  # Keep existing opacity function
  opacityToHex = opacityValue:
    let
      alphaInt = builtins.floor (opacityValue * 255);
      toHexDigit = n:
        builtins.elemAt [
          "0"
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "a"
          "b"
          "c"
          "d"
          "e"
          "f"
        ] n;
      high = toHexDigit (alphaInt / 16);
      low = toHexDigit (lib.mod alphaInt 16);
    in high + low;

  inherit adaptSchemeToWallpaper;
}
