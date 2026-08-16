{ pkgs, ... }: {
  services.swayidle = let
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
  in {
    enable = true;
    timeouts = [
      {
        timeout = 60;
        command = lock;
      }
      {
        timeout = 120;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 180;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };
}
