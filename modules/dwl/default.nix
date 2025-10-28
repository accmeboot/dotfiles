{ pkgs, ... }:
let
  # Fetch dwl source from git
  dwlSource = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "dwl";
    repo = "dwl";
    rev = "v0.7";
    hash = "sha256-7SoCITrbMrlfL4Z4hVyPpjB9RrrjLXHP9C5t1DVXBBA=";
  };

  # Build dwl from source
  customDwl = pkgs.stdenv.mkDerivation rec {
    pname = "dwl";
    version = "0.7";
    
    src = dwlSource;
    
    # Copy your config before building
    postPatch = ''
      echo "Copying custom config..."
      cp ${./src/config.def.h} config.def.h
      echo "Config copied successfully"
    '';
    
    # Dependencies dwl needs to build (from the docs)
    buildInputs = with pkgs; [
      # Core dependencies from docs
      libinput
      wayland
      wayland-protocols    # Add this - it's missing!
      wlroots_0_18
      libxkbcommon
      
      # Additional dependencies for XWayland
      xorg.libxcb
      xorg.xcbutil
      xorg.xcbutilwm  # This provides xcb-icccm
      
      # For your patches
      libdrm       # for bar patch - provides libdrm/drm_fourcc.h
      pixman       # for bar patch
      fcft         # for bar patch
      dbus         # for systray patch
    ];

    # Tools needed during build (from docs)
    nativeBuildInputs = with pkgs; [
      pkg-config
      wayland-scanner
    ];
    
    # Runtime dependencies
    propagatedBuildInputs = with pkgs; [
      xwayland
    ];
    
    # Apply your patches in order
    patches = [
      ./src/patches/xwayland-enable.patch
      ./src/patches/bar-0.7.patch
      ./src/patches/bar-systray-0.7.patch
      ./src/patches/autostart-0.7.patch
      ./src/patches/alwayscenter.patch
    ];

    # Simplified build configuration - let config.mk handle XWayland
    makeFlags = [ 
      "PKG_CONFIG=${pkgs.pkg-config}/bin/pkg-config" 
      "PREFIX=$(out)"
      "MANDIR=$(out)/share/man"
    ];
    
    meta = {
      description = "Dynamic window manager for Wayland (custom build with XWayland)";
      homepage = "https://codeberg.org/dwl/dwl";
      license = pkgs.lib.licenses.gpl3Only;
      platforms = pkgs.lib.platforms.linux;
    };
  };

  # Your existing status wrapper
  dwlWithStatus = pkgs.writeShellScriptBin "dwl" ''
    exec bash -c '
      (while true; do 
        stats=$($HOME/dotfiles/scripts/stats/get-stats.sh || echo "Stats Error")
        datetime=$(date +"%H:%M")
        echo " $stats $datetime"
        sleep 1
      done) | exec ${customDwl}/bin/dwl "$@"
    '
  '';
in
{
  programs.dwl = {
    enable = true;
    package = dwlWithStatus;
  };
}
