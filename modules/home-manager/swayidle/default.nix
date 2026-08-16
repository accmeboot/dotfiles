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
    events = {
      before-sleep = (display "off") + "; " + lock;
      after-resume = display "on";
      lock = (display "off") + "; " + lock;
      unlock = display "on";
    };
  };
}
