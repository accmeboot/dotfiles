{ lib, ... }: {
  programs.opencode = {
    enable = true;
    settings = { theme = lib.mkForce "system"; };
  };
}

