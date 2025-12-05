{ config, pkgs, lib, ... }: {
  home.packages = lib.mkIf config.stylix.desktop.enableIcons [
    (pkgs.writeShellApplication {
      name = "sync-papirus-icons";
      runtimeInputs = with pkgs; [
        python3
        findutils
        coreutils
        papirus-icon-theme
        parallel
      ];
      text = ''
        echo "Recoloring Papirus icons with Stylix palette..."

        # Build color palette from Stylix colors
        PALETTE=(
          "#${config.lib.stylix.colors.base00}"
          "#${config.lib.stylix.colors.base01}"
          "#${config.lib.stylix.colors.base02}"
          "#${config.lib.stylix.colors.base03}"
          "#${config.lib.stylix.colors.base04}"
          "#${config.lib.stylix.colors.base05}"
          "#${config.lib.stylix.colors.base06}"
          "#${config.lib.stylix.colors.base07}"
          "#${config.lib.stylix.colors.base08}"
          "#${config.lib.stylix.colors.base09}"
          "#${config.lib.stylix.colors.base0A}"
          "#${config.lib.stylix.colors.base0B}"
          "#${config.lib.stylix.colors.base0C}"
          "#${config.lib.stylix.colors.base0D}"
          "#${config.lib.stylix.colors.base0E}"
          "#${config.lib.stylix.colors.base0F}"
        )

        echo "Color palette: ''${PALETTE[*]}"

        # Create local icons directory
        mkdir -p "$HOME/.local/share/icons"

        # Copy Papirus themes
        for theme in Papirus Papirus-Dark Papirus-Light; do
          echo "Copying $theme..."
          rm -rf "$HOME/.local/share/icons/$theme"
          cp -r "${pkgs.papirus-icon-theme}/share/icons/$theme" "$HOME/.local/share/icons/"
          chmod -R u+w "$HOME/.local/share/icons/$theme"
        done

        # Export palette and script path for parallel
        export PALETTE_STR="''${PALETTE[*]}"
        export RECOLOR_SCRIPT="${../../../scripts/recolorsvg.py}"

        # Recolor all SVG icons in parallel
        for theme in Papirus Papirus-Dark Papirus-Light; do
          theme_dir="$HOME/.local/share/icons/$theme"
          
          if [ ! -d "$theme_dir" ]; then
            echo "  Warning: $theme_dir not found, skipping..."
            continue
          fi

          echo "Recoloring $theme icons (using all CPU cores)..."
          
          # Count total icons
          total_icons=$(find "$theme_dir" -name "*.svg" -type f | wc -l)
          echo "  Found $total_icons SVG files"
          
          if [ "$total_icons" -eq 0 ]; then
            echo "  No SVG files found in $theme_dir"
            continue
          fi
          
          # Process icons in parallel
          # shellcheck disable=SC2016
          find "$theme_dir" -name "*.svg" -type f | \
            parallel --will-cite --bar --jobs 90% '
              temp_file="{}.tmp"
              if python3 "$RECOLOR_SCRIPT" $PALETTE_STR < "{}" > "$temp_file" 2>/dev/null; then
                if [ -s "$temp_file" ]; then
                  mv "$temp_file" "{}"
                else
                  rm -f "$temp_file"
                fi
              else
                rm -f "$temp_file"
              fi
            '
          
          echo "  ✓ Completed $theme"
        done

        # Update icon cache
        echo "Updating icon cache..."
        for theme in Papirus Papirus-Dark Papirus-Light; do
          if [ -d "$HOME/.local/share/icons/$theme" ]; then
            gtk-update-icon-cache -f -t "$HOME/.local/share/icons/$theme" 2>/dev/null || true
          fi
        done

        echo "✓ Icon recoloring complete!"
        echo "You may need to restart your desktop session for changes to take effect."
      '';
    })
  ];
}
