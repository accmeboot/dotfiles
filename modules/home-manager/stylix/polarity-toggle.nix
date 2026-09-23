{
  config,
  pkgs,
  lib,
  ...
}:
let
  isDark = config.stylix.polarity == "dark";
  location = {
    lat = 44.8;
    lng = 20.5;
  };
  mkApplier =
    {
      name,
      polarity,
      subdir,
    }:
    lib.lowPrio (
      pkgs.writeShellApplication {
        inherit name;
        runtimeInputs = with pkgs; [
          coreutils
          nix
          procps
        ];
        text = ''
          current_gen=$(nix-store --query --requisites /run/current-system | grep "home-manager-generation$" | while read -r gen; do
            if [[ -d "$gen/specialisation/light" ]]; then
              echo "$gen"
              break
            fi
          done)

          if [[ -z "$current_gen" ]]; then
            echo "No home-manager generation with light specialisation found"
            exit 1
          fi

          echo "Switching to ${polarity} theme: $current_gen${subdir}"
          "$current_gen"${subdir}/activate

          pkill -USR2 ghostty || true
          qs -c mesa-shell ipc call config reload || true
        '';
      }
    );

  appliers = {
    light = mkApplier {
      name = "apply-light-theme";
      polarity = "light";
      subdir = "/specialisation/light";
    };
    dark = mkApplier {
      name = "apply-dark-theme";
      polarity = "dark";
      subdir = "";
    };
  };
  applyScript = ''
    case "$1" in
      light) exec ${lib.getExe appliers.light} ;;
      dark) exec ${lib.getExe appliers.dark} ;;
      *)
        echo "unknown mode: $1" >&2
        exit 1
        ;;
    esac
  '';
  mkSetter =
    { name, mode }:
    lib.lowPrio (
      pkgs.writeShellApplication {
        inherit name;
        runtimeInputs = [ config.services.darkman.package ];
        text = ''
          darkman set ${mode}
        '';
      }
    );
in
{
  config = lib.mkMerge [
    {
      # Stylix names the theme "adw-gtk3" for both polarities and keeps the
      # actual colors in ~/.config/gtk-*.0/gtk.css, which GTK only parses at
      # startup. A distinct name per polarity makes the dconf gtk-theme key
      # change during activation, so running GTK3 apps re-read the theme from
      # ~/.themes/<name> - where stylix has already appended the base16 colors
      # for us (stylix.targets.gtk.flatpakSupport).
      gtk.theme.name = lib.mkForce (if isDark then "adw-gtk3-dark" else "adw-gtk3");
      xdg.configFile."gtk-3.0/gtk.css".enable = false;
    }
    (lib.mkIf config.isMacos {
      home.packages = [
        (mkApplier {
          name = "set-light-theme";
          polarity = "light";
          subdir = "/specialisation/light";
        })

        (mkApplier {
          name = "set-dark-theme";
          polarity = "dark";
          subdir = "";
        })
      ];
    })

    (lib.mkIf (!config.isMacos) {
      home.packages = [
        appliers.light
        appliers.dark

        (mkSetter {
          name = "set-light-theme";
          mode = "light";
        })
        (mkSetter {
          name = "set-dark-theme";
          mode = "dark";
        })
      ];

      services.darkman = {
        enable = true;
        settings = {
          inherit (location) lat lng;
          usegeoclue = false;
        };
        scripts.stylix = applyScript;
      };
      systemd.user.services.darkman = {
        Unit = {
          PartOf = lib.mkForce [ "sway-session.target" ];
          BindsTo = lib.mkForce [ "sway-session.target" ];
          After = [ "quickshell.service" ];
        };
        Install.WantedBy = [ "sway-session.target" ];
      };
    })
  ];
}
