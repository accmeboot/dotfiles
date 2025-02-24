{ config, pkgs, ... }:
{
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = pkgs.symlinkJoin {
      name = "eww";
      paths = [
        (pkgs.writeTextDir "eww.scss" ''
          // Global Styles
          .bar {
            background-color: #${config.lib.stylix.colors.base00};
            color: #${config.lib.stylix.colors.base05};
            padding: 2px 8px;
          }

          .leftbar {
            .launcher {
              all: unset;

              &:hover {
                color: #${config.lib.stylix.colors.base0D};
              }
            }

            .workspaces {
              margin-left: 8px;

              button {
                all: unset;
                padding: 0px 6px;
                margin: 0px 2px;
                background-color: #${config.lib.stylix.colors.base01};
                border-top: 2px solid #${config.lib.stylix.colors.base01};
                border-bottom: 2px solid #${config.lib.stylix.colors.base01};
                opacity: 0.6;

                &:hover {
                  color: #${config.lib.stylix.colors.base0D};
                }

                &.active {
                  border-bottom: 2px solid #${config.lib.stylix.colors.base0D};
                  opacity: 1;
                }

                &.urgent {
                  color: #${config.lib.stylix.colors.base09};
                }
              }
            }
          }

          .rightbar {
            .audio {
              margin-right: 8px;

              .audio-button {
                all: unset;

                &:hover {
                  color: #${config.lib.stylix.colors.base0D};
                }
              }

              slider {
                all: unset;
              }

              scale {
                all: unset;
                margin-left: 4px;

                trough {
                  min-height: 5px;
                  min-width: 80px;

                  highlight {
                    background-color: #${config.lib.stylix.colors.base0D};
                    border-radius: 4px;
                  }
                }
              }
            }

            .temps {
              margin-right: 8px;

              .cpu,
              .gpu {
                padding-right: 4px;
              }

              .cpu {
                color: #${config.lib.stylix.colors.base09};
              }

              .gpu {
                color: #${config.lib.stylix.colors.base0A};
              }

              .ram {
                color: #${config.lib.stylix.colors.base0D};
              }
            }

            .locale {
              margin-right: 8px;
            }

            .tray {
              margin-right: 8px;
              margin-top: 2px;
            }
          }
         '')
          (pkgs.writeTextDir "eww.yuck" ''
            (defwidget bar []
              (centerbox :orientation "h"
                (leftbar)
                (centerbar)
                (rightbar)))

            (defwidget leftbar []
              (box :class "leftbar"
                   :orientation "h"
                   :space-evenly false
                   :halign "start"
                (launcher)
                (workspaces)))

            (defwidget centerbar [] (box))
            (defwidget rightbar []
              (box :class "rightbar"
                   :orientation "h"
                   :space-evenly false
                   :halign "end"
                (audio)
                (temps)
                (tray)
                (locale)
                (date)))

            ;;;;;;;;;;;;;;;;;;;;;;;;;
            ;;                     ;;
            ;;   Leftbar Content   ;;
            ;;                     ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;
            (defwidget launcher []
              (button :class "launcher"
                      :onclick "rofi -show drun &"
                      " "))

            (defwidget workspaces []
              (eventbox
                  :onscroll `bash change-workspace.sh {}`
              (box :class "workspaces"
                   :orientation "h"
                   :space-evenly true
                   :halign "start"
                (for workspace in workspace-list
                  (button :class {(workspace.focused ? "active" : workspace.urgent ? "urgent" : "")}
                          :onclick "swaymsg workspace ''${workspace.name}"
                          "''${workspace.name}")))))

            ;;;;;;;;;;;;;;;;;;;;;;;;;
            ;;                     ;;
            ;;   Rightbar Content  ;;
            ;;                     ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;
            (defwidget date []
              (eventbox :onclick "eww open --toggle calendar"
                        (box :class "date"
                             :orientation "h"
                             :space-evenly false
                             :halign "end"
                          (label :text time))))

            (defwidget tray []
              (box :class "tray"
                   :orientation "h"
                   :space-evenly false
                   :halign "end"
                (systray :spacing 4
                         :icon-size 16)))


            (defwidget locale []
              (box :class "locale"
                   :orientation "h"
                   :space-evenly false
                   :halign "end"
                (label :class "locale-text"
                       :text "   ''${locale}")))

            (defwidget temps []
              (box :class "temps"
                   :orientation "h"
                   :space-evenly false
                   :halign "end"
                (label :class "cpu"
                       :text "CPU ''${cpu}°C ")
                (label :class "gpu"
                       :text "GPU ''${gpu}°C ")
                (label :class "ram"
                       :text "MEM ''${memory}%")))

            (defwidget audio []
              (box :class "audio"
                   :orientation "h"
                   :space-evenly false
                   :halign "end"
                (label :class "audio-icon" :text {is-muted == "true" ? "  " : "  "})
                (metric :class "audio"
                        :label "''${output-name}"
                        :value volume
                        :btnclass "audio-button"
                        :onclick "pavucontrol &"
                        :onchange "wpctl set-volume @DEFAULT_AUDIO_SINK@ {}% && bash volume-notify.sh")))

            (defwidget metric [class label value btnclass onchange onclick]
              (box :orientation "h"
                   :class class
                   :space-evenly false
                (button :class btnclass
                        :onclick onclick
                        label)
                (scale :min 0
                       :max 153
                       :active {onchange != ""}
                       :value value
                       :onchange onchange)))



            ;; Listen variables
            (deflisten volume :initial "0" "bash get-volume.sh")
            (deflisten is-muted :initial "false" "bash get-is-muted.sh")
            (deflisten workspace-list :initial "[]" "bash get-workspaces.sh")

            ;; Polling variables
            (defpoll cpu :interval "1s" "bash get-cpu-temp.sh")
            (defpoll gpu :interval "1s" "bash get-gpu-temp.sh")
            (defpoll output-name :interval "1s" "bash get-output-name.sh")
            (defpoll is-tray-visible :interval "1s" "bash get-systray-status.sh")
            (defpoll locale :interval "1s" "bash get-locale.sh")
            (defpoll memory :interval "1s" "bash get-ram.sh")
            (defpoll time :interval "1s" "date '+%A, %d %b %Y, %H:%M'")

            (defwindow bar
              :monitor 0
              :geometry (geometry :x "0px"
                                  :y "0px"
                                  :width "100%"
                                  :anchor "top center")
              :stacking "bg"
              :reserve (struts :distance "0px" :side "top")
              :exclusive true
              :windowtype "dock"
            (bar))

            (defwindow calendar
              :monitor 0
              :geometry (geometry :x "0px"
                                  :y "8px"
                                  :width "200px"
                                  :anchor "top right")
              :stacking "fg"
              :wm-ignore true
              (calendar))
           '')

          (pkgs.writeTextDir "get-volume.sh" ''
            ${builtins.readFile ../../scripts/get-volume.sh}
          '')
          (pkgs.writeTextDir "get-is-muted.sh" ''
            ${builtins.readFile ../../scripts/get-is-muted.sh}
          '')
          (pkgs.writeTextDir "get-workspaces.sh" ''
            ${builtins.readFile ../../scripts/get-workspaces.sh}
          '')
          (pkgs.writeTextDir "get-cpu-temp.sh" ''
            ${builtins.readFile ../../scripts/get-cpu-temp.sh}
          '')
          (pkgs.writeTextDir "get-gpu-temp.sh" ''
            ${builtins.readFile ../../scripts/get-gpu-temp.sh}
          '')
          (pkgs.writeTextDir "get-output-name.sh" ''
            ${builtins.readFile ../../scripts/get-output-name.sh}
          '')
          (pkgs.writeTextDir "get-systray-status.sh" ''
            ${builtins.readFile ../../scripts/get-systray-status.sh}
          '')
          (pkgs.writeTextDir "get-locale.sh" ''
            ${builtins.readFile ../../scripts/get-locale.sh}
          '')
          (pkgs.writeTextDir "get-ram.sh" ''
            ${builtins.readFile ../../scripts/get-ram.sh}
          '')
          (pkgs.writeTextDir "change-workspace.sh" ''
            ${builtins.readFile ../../scripts/change-workspace.sh}
          '')
          (pkgs.writeTextDir "volume-notify.sh" ''
            ${builtins.readFile ../../scripts/volume-notify.sh}
          '')
      ];
    };
  };
}
