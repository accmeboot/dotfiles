{ config, pkgs, ... }: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    gnome.gnome-keyring.enable = true;

    envfs.enable = true;

    greetd = {                                                      
      enable = true;                                                         
      settings = {                                                           
        default_session = {                                                  
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";                                                  
        };                                                                   
      };                                                                     
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              rightcontrol = "rightmeta";
            };
            otherlayer = {};
          };
        };
      };
    };
  };
}
