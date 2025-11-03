{ lib, ... }: {
  programs.opencode = {
    enable = true;
    settings = {
      theme = lib.mkForce "system";
      permission = {
        edit = "ask";
        bash = "ask";
        webfetch = "ask";
      };
    };
  };
}

