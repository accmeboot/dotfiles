{ pkgs, ... }:
{
  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs.obs-studio.enable = true;

  #----------------------------------------------------------------------------#
  # PACKAGES                                                                   #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    # Media & Viewers
    mpv # video player
    vlc # video player
    gimp # image editor
    brave # browser
    pinta # image viewer

    # Communication & Entertainment
    telegram-desktop # messaging application
    spotify # music streaming service
    discord # chat and voice communication platform
    thunderbird # email client
    transmission_4-gtk # torrent client
  ];
}
