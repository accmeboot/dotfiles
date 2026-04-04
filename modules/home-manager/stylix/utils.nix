{ pkgs, lib }: {
  generateMatugenScheme = imagePath: polarity:
    let
      colorMapping = {
        base00 = "surface_container_lowest";
        base01 = "surface_container";
        base02 = "surface_container_highest";
        base03 = "outline";
        base04 = "on_surface_variant";
        base05 = "on_surface";
        base06 = "secondary_fixed";
        base07 = "primary";
        base08 = "error";
        base09 = "tertiary";
        base0A = "secondary";
        base0B = "primary";
        base0C = "primary_fixed";
        base0D = "surface_tint";
        base0E = "tertiary_fixed";
        base0F = "on_error_container";
      };

      matugenColors = pkgs.runCommand "matugen-colors" {
        buildInputs = [ pkgs.matugen pkgs.jq ];
      } ''
        ${pkgs.matugen}/bin/matugen image ${imagePath} \
          --mode ${polarity} \
          --type scheme-tonal-spot \
          --json hex \
          --dry-run \
          --source-color-index 0 \
          2>/dev/null | ${pkgs.jq}/bin/jq -r '.colors | 
            to_entries | 
            map({key: .key, value: .value.${polarity}.color}) | 
            from_entries' > $out
      '';

      materialColors = builtins.fromJSON (builtins.readFile matugenColors);
    in builtins.mapAttrs
    (_: materialName: lib.removePrefix "#" materialColors.${materialName})
    colorMapping;

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
}
