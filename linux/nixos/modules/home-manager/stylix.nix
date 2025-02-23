{ config, pkgs, ... }: 
{
  stylix = {
   enable = true;
   image = ../../../../assets/wallpapers/nix-wallpaper-binary-black.png;
   polarity = "dark";
   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

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
