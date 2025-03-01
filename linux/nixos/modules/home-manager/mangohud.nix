{ config, lib, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    settings = {
      alpha = lib.mkForce 0.6;
      background_alpha = lib.mkForce 0.6;
      legacy_layout = 0;
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      vram = true;
      ram = true;
      fps = true;
      frametime = true;
      frame_timing = true;
      text_outline = true;
      no_display = true;
      toggle_hud = "Shift_L+F12";
      reload_cfg = "Shift_L+F4";
      pci_dev = "0000:03:00.0";
      font_size = lib.mkForce 18;
      font_size_text = lib.mkForce 18;
    };
  };
}
