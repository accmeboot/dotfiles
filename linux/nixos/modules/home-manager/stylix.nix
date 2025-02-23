{ config, pkgs, ... }: 
{
  stylix = {
   enable = true;
   image = ../../../../assets/wallpapers/nix-wallpaper-binary-black.png;
   polarity = "dark";
   base16Scheme = {
     scheme = "Custom Gruvbox";
     author = "accme";
     base00 = "282828";
     base01 = "3a3735";
     base02 = "3a3735";
     base03 = "3a3735";
     base04 = "d4be98";
     base05 = "d4be98";
     base06 = "d4be98";
     base07 = "d4be98";
     base08 = "ea6962";
     base09 = "e78a4e";
     base0A = "d8a657";
     base0B = "a9b665";
     base0C = "89b482";
     base0D = "7daea3";
     base0E = "d3869b";
     base0F = "ea6962";
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
