{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "dwlmsg";
  version = "0-unstable-2026-01-31";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "notchoc";
    repo = "dwlmsg";
    rev = "7be655ef47c80136c4a4132767423c1db5085d02";
    hash = "sha256-eaeR8jhZDulysBRCRWjh6YgbLQQPja8PPMeR8V6UmxQ=";
  };

  patches = [ ./dwl-ipc.patch ];

  strictDeps = true;
  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.wayland-scanner
  ];
  buildInputs = [ pkgs.wayland ];

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "WAYLAND_SCANNER=wayland-scanner"
  ];

  meta.mainProgram = "dwlmsg";
}
