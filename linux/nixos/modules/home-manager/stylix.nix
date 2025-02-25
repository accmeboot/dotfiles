{ config, pkgs, ... }: 
{
  stylix = {
   enable = true;
   image = ../../../../assets/wallpapers/bay.JPG;
   polarity = "dark";
   base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

   targets = {
     kitty.enable = false;
     neovim.enable = false;
     tmux.enable = false;
     rofi.enable = false;
   };

   fonts.sizes = {
     applications = 9;
     desktop = 9;
     popups = 9;
   };
  };
}
