{ config, lib, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      
      directory = {
        format = "[$path]($style) ";
        style = "blue";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[git:\\($branch\\)]($style)";
        style = "bright-black";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "red";
      };

      line_break = {
        disabled = true;
      };

      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };
}
