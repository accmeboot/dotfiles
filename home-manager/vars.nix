{ lib, ... }: {
  # Variables set by profiles and read by the modules in this directory.
  options = {
    isMacos = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether running on macOS to disable Linux-specific theming";
    };
  };
}
