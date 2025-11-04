{ lib, ... }: {
  programs.opencode = {
    enable = true;
    settings = {
      theme = lib.mkForce "system";
      autoupdate = true;
      permission = {
        edit = "ask";
        bash = "ask";
        webfetch = "ask";
      };
    };
  };
}

