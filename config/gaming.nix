{ pkgs, ... }:
{
  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs = {
    gamescope = {
      enable = true;
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      });
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  #----------------------------------------------------------------------------#
  # PACKAGES                                                                   #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    protonup-rs # installing proton ge
  ];

  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    PROTON_ENABLE_WAYLAND = 1;
    PROTON_DXVK_LOWLATENCY = 1;
  };
}
