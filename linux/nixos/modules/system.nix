{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";  # for UEFI systems
          efiSupport = true;
          useOSProber = true;  # if you want to detect other OS
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";  # your EFI mount point
      };
    };

    initrd.kernelModules = [ "amdgpu" ];  # early load amdgpu
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

  # kanshi systemd service
  # we don't run Sway itself as a systemd service.
  # There are auxiliary daemons that we do want to run
  # as systemd services, for example Kanshi
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY="wayland-1";
      DISPLAY = ":0";
    }; 
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
}
