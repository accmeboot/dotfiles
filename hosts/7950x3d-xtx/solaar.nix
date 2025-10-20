{ config, pkgs, lib, ... }: {
  services.solaar = {
    enable = false; # Enable the service
      package = pkgs.solaar; # The package to use
      window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      batteryIcons = "solaar"; # Which battery icons to use (*regular*, symbolic, solaar)
      extraArgs = ""; # Extra arguments to pass to solaar on startup
  };
}
