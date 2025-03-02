{ config, pkgs, ... }: {
  users.users.accme = {
    isNormalUser = true;
    description = "accme";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;
}
