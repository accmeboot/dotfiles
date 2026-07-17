{ inputs, pkgs, ... }: {
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home.file.".local/share/icons/default" = {
    source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors/";
    recursive = true;
  };

  programs.plasma = {
    enable = true;

    workspace.wallpaper = "${../../../assets/wallpapers/grass.png}";

    shortcuts = {
      "kwin"."Window Close" = "Meta+C";

      "kwin"."Switch to Desktop 1" = "Meta+1";
      "kwin"."Switch to Desktop 2" = "Meta+2";
      "kwin"."Switch to Desktop 3" = "Meta+3";
      "kwin"."Switch to Desktop 4" = "Meta+4";
    };

    panels = [{
      location = "top";
      height = 36;
      lengthMode = "fit";
      alignment = "center";
      widgets = [
        "org.kde.plasma.kickoff"
        {
          name = "org.kde.plasma.pager";
          config.General = {
            displayedText = "Number";
            showWindowOutlines = false;
          };
        }
        {
          name = "org.kde.plasma.icontasks";
          config.General = {
            launchers = [ ];
            fill = false;
            indicateAudioStreams = false;
            interactiveMute = false;
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          name = "org.kde.plasma.panelspacer";
          config.General.expanding = false;
        }
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
    }];
  };
}
