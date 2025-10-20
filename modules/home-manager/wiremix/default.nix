{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries = {
    wiremix = {
      name = "WireMix";
      comment = "Terminal-based PipeWire audio mixer";
      exec = "kitty --class wiremix wiremix";
      icon = "audio-volume-high";
      terminal = false;
      categories = [ "AudioVideo" "Audio" "Mixer" ];
    };
  };
}
