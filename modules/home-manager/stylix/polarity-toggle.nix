{ config, pkgs, lib, ... }:
let
  isDark = config.stylix.polarity == "dark";

  mkSwitcher = { name, polarity, subdir }:
    lib.lowPrio (pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [ coreutils nix procps ];
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
      '';
    });
in {
  config = {
    # Stylix names the theme "adw-gtk3" for both polarities and keeps the
    # actual colors in ~/.config/gtk-*.0/gtk.css, which GTK only parses at
    # startup. A distinct name per polarity makes the dconf gtk-theme key
    # change during activation, so running GTK3 apps re-read the theme from
    # ~/.themes/<name> - where stylix has already appended the base16 colors
    # for us (stylix.targets.gtk.flatpakSupport).
    gtk.theme.name =
      lib.mkForce (if isDark then "adw-gtk3-dark" else "adw-gtk3");

    # This one is loaded above the theme and never re-read, so it would keep
    # pinning the colors the app saw at startup. GTK4/libadwaita ignores named
    # themes and has no other source for them, so only GTK3's copy goes away.
    xdg.configFile."gtk-3.0/gtk.css".enable = false;

    home.packages = [
      (mkSwitcher {
        name = "set-light-theme";
        polarity = "light";
        subdir = "/specialisation/light";
      })

      (mkSwitcher {
        name = "set-dark-theme";
        polarity = "dark";
        subdir = "";
      })
    ];
  };
}
