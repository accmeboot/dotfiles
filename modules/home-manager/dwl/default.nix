{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (dwl.overrideAttrs (oldAttrs: rec {
      # Use your local submodule source
      src = ./src;
      
      # Remove any existing patches since we're using custom source
      patches = [];
      
      # dwl dependencies from the docs
      buildInputs = with pkgs; [
        # Core dependencies
        libinput
        wayland
        wlroots
        libxkbcommon
        
        # XWayland support (optional but recommended)
        xorg.libxcb
        xorg.xcbutilwm
        xwayland
      ];
      
      nativeBuildInputs = with pkgs; [
        # Compile-time dependencies
        pkg-config
        wayland-protocols
        wayland-scanner
      ];
      
      # Copy and potentially modify config
      postPatch = ''
        # Copy default config
        # cp config.def.h config.h
        
        # Enable XWayland support (uncomment in config.mk)
        # sed -i 's/^#XWAYLAND/XWAYLAND/' config.mk
        
        # You can add custom config modifications here
        # sed -i 's/some_default/your_value/' config.h
      '';
      
      # Use make build system
      buildPhase = ''
        make
      '';
      
      installPhase = ''
        make install PREFIX=$out
      '';
    }))
  ];
}
