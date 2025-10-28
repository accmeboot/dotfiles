{ pkgs, ... }:
let
  # First build your custom dwl with all patches
  customDwl = (pkgs.dwl.override {
    configH = ./src/config.def.h;
  }).overrideAttrs (oldAttrs: {
    buildInputs =
      oldAttrs.buildInputs or []
      ++ [
        pkgs.libdrm
        pkgs.fcft
        pkgs.dbus
      ];
    patches = oldAttrs.patches or [] ++ [
      ./src/patches/bar-0.7.patch
      ./src/patches/bar-systray-0.7.patch
      ./src/patches/autostart-0.7.patch
      ./src/patches/gaps.patch
    ];
  });

  # Then create a wrapper that pipes status to your custom dwl
  dwlWithStatus = pkgs.writeShellScriptBin "dwl" ''
    # Use exec to replace the shell process entirely
    exec bash -c '
      (while true; do 
        stats=$($HOME/dotfiles/scripts/stats/get-stats.sh || echo "Stats Error")
        datetime=$(date +"%a %d %H:%M")
        echo " $stats  $datetime"
        sleep 1
      done) | exec ${customDwl}/bin/dwl "$@"
    '
  '';
in
{
  programs.dwl = {
    enable = true;
    package = dwlWithStatus;  # Use the wrapper instead
  };
}
