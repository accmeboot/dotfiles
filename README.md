# Dotfiles

This repository contains dotfiles managed declaratively with [Nix](https://nixos.org/), [Home Manager](https://nix-community.github.io/home-manager/), and [nix-darwin](https://github.com/LnL7/nix-darwin). It supports both NixOS and macOS, and includes modular configurations for:

- NixOS and macOS system settings
- Home Manager user environment
- Neovim (with plugins and custom Lua config)
- Tmux
- Stylix theming
- And more (see the `modules/home-manager` directory)

Configuration is organized by system and tool for easy navigation and setup.

### Secrets & API Keys
Sensitive data (like API keys) should **not** be committed to the repo. Instead, store secrets in a `~/.env` file (which is sourced automatically by the shell config) or use a password manager. See the relevant module README or comments for details.

## Showcase

![Showcase 1](/assets/showcase/1.png)
![Showcase 2](/assets/showcase/2.png)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE.md](LICENSE.md) file for details.
