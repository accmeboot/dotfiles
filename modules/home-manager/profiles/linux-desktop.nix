{ inputs, ... }: {
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    workspace.wallpaper = "${../../../assets/wallpapers/grass.png}";

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
