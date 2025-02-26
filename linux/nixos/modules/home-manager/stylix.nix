{ config, pkgs, ... }: 
{
  stylix = {
   enable = true;
   image = ../../../../assets/wallpapers/bay.JPG;
   polarity = "dark";

   # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
   base16Scheme = {
     scheme = "Custom Gruvbox";
     author = "accme";
     base00 = "1C1917"; 
     base01 = "2D2927"; 
     base02 = "3E3937"; 
     base03 = "756E6B"; 
     base04 = "988F8C"; 
     base05 = "DBD6D1"; 
     base06 = "ECE7E2"; 
     base07 = "FAF5F0"; 
     base08 = "C5907B"; 
     base09 = "C4B187"; 
     base0A = "D7C897"; 
     base0B = "B8C196"; 
     base0C = "A699B7"; 
     base0D = "9F8B96"; 
     base0E = "B8B0A4"; 
     base0F = "7B9F7B"; 
   };


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
