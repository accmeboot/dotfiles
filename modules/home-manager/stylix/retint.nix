{ pkgs, lib }:
let
  source = lib.removePrefix ''
    #!/usr/bin/env python3
  '' (builtins.readFile ../../../scripts/retint.py);

  package = pkgs.writers.writePython3Bin "retint" {
    libraries = with pkgs.python3Packages; [ numpy pillow ];
    flakeIgnore = [ "E501" ];
  } source;
in {
  inherit package;

  mkScheme =
    { scheme, image, rotate ? 15, tint ? 0.15, maxRampChroma ? 3.0e-2, }:
    "${pkgs.runCommand
    "${lib.removeSuffix ".yaml" (baseNameOf scheme)}-retinted.yaml" { } ''
      ${package}/bin/retint \
        --scheme ${scheme} \
        --image ${image} \
        --rotate ${toString rotate} \
        --tint ${toString tint} \
        --max-ramp-chroma ${toString maxRampChroma} \
        > $out
    ''}";
}
