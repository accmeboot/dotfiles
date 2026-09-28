{ pkgs, ... }:
{
  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs = {
    # Runs unpatched dynamic binaries (e.g. LSPs downloaded by mason).
    nix-ld.enable = true;
    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  #----------------------------------------------------------------------------#
  # PACKAGES                                                                   #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty # modern terminal emulator

    # Core Development Tools
    vim # terminal text editor
    gcc # GNU Compiler Collection
    cmake # cross-platform build system generator
    gnumake # build automation tool
    git # version control system
    nil # nix language server
    jetbrains.idea # ide
    jdk21 # java development kit
    gradle # jvm build tool (kotlin-language-server resolves its classpath through it)
    httpie # better curl
    claude-code # Agentic coding tool
    ollama # running local llms

    # Programming Languages
    python3 # python programming language
    nodejs # JavaScript runtime environment
    go # go programming language
    rustup # rust toolchain installer
    lua # lua programming language
    luarocks # package manager for Lua modules
  ];

  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#
  environment.sessionVariables = {
    LUA_PATH = "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
