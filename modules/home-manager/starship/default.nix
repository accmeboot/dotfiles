{ config, lib, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "[](color_orange)$directory[](fg:color_orange bg:color_red)$git_branch$git_status[](fg:color_red bg:color_blue)$c$cpp$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$docker_context$conda$pixi[](fg:color_bg3 bg:color_bg1)$cmd_duration[ ](fg:color_bg1)$line_break$character";

      palettes.gruvbox_dark = {
        color_fg0     = "#${config.theme.colors.base07}";
        color_bg1     = "#${config.theme.colors.base01}";
        color_bg3     = "#${config.theme.colors.base03}";
        color_blue    = "#${config.theme.colors.base0D}";
        color_aqua    = "#${config.theme.colors.base0C}";
        color_green   = "#${config.theme.colors.base0B}";
        color_orange  = "#${config.theme.colors.base09}";
        color_purple  = "#${config.theme.colors.base0E}";
        color_red     = "#${config.theme.colors.base08}";
        color_yellow  = "#${config.theme.colors.base0A}";
      };

      palette = "gruvbox_dark";

      directory = {
        style = "fg:color_fg0 bg:color_orange";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:color_red";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_red)]($style)";
      };

      git_status = {
        style = "bg:color_red fg:color_bg1";
        format = "[[($all_status$ahead_behind )](fg:color_bg1 bg:color_red)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ($virtualenv) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#${config.theme.colors.base0D} bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#${config.theme.colors.base0D} bg:color_bg3)]($style)";
      };

      pixi = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)";
      };

      cmd_duration = {
        format = "[  $duration]($style)";
        style = "bg:color_bg1";
      };

      line_break = { disabled = true; };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:color_green)";
        error_symbol = "[❯](bold fg:color_red)";
        vimcmd_symbol = "[❮](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:color_purple)";
        vimcmd_replace_symbol = "[❮](bold fg:color_purple)";
        vimcmd_visual_symbol = "[❮](bold fg:color_yellow)";
      };
    };
  };
}
