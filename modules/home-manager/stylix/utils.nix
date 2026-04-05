{ pkgs, lib }: {
  generateMatugenScheme = imagePath: polarity:
    let
      colorMapping = {
        base00 = "surface_container_lowest"; # Darkest background
        base01 = "surface_container"; # Container background
        base02 = "surface_container_high"; # Elevated surface
        base03 = "outline"; # Borders/comments
        base04 = "on_surface_variant"; # Muted text
        base05 = "on_surface"; # Primary text
        base06 = "surface_bright"; # Bright surface
        base07 = "inverse_surface"; # Lightest foreground
        base08 = "error"; # Red/errors
        base09 = "on_error_container"; # Orange-ish (light red variant)
        base0A = "on_primary_container"; # Yellow (from primary palette)
        base0B = "tertiary"; # Green (this is the green palette!)
        base0C = "on_tertiary_container"; # Cyan (light green variant)
        base0D = "primary"; # Blue/primary accent
        base0E = "on_secondary_container"; # Purple-ish (light secondary)
        base0F = "secondary"; # Brown/secondary accent
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
