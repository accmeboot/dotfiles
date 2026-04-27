{ pkgs, lib }: {
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
