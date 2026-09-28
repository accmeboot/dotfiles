{ pkgs, lib, ... }:
{
  #----------------------------------------------------------------------------#
  # HARDWARE                                                                   #
  #----------------------------------------------------------------------------#
  # udev rules for Logitech receivers, so solaar can access them.
  hardware.logitech.wireless.enable = true;

  #----------------------------------------------------------------------------#
  # PACKAGES                                                                   #
  #----------------------------------------------------------------------------#
  environment.systemPackages = [ pkgs.solaar ];

  #----------------------------------------------------------------------------#
  # SERVICES                                                                   #
  #----------------------------------------------------------------------------#
  systemd.user.services.solaar = {
    description = "Solaar";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${lib.getExe pkgs.solaar} --window=hide";
  };
}
