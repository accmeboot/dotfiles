# Dotfiles

This repository contains dotfiles managed declaratively with [Nix](https://nixos.org/) flakes, [Home Manager](https://nix-community.github.io/home-manager/), and [nix-darwin](https://github.com/LnL7/nix-darwin). It supports both NixOS and macOS.

## Showcase

![Showcase 1](/assets/showcase/1.png)

## Features

- **[dwl](https://codeberg.org/dwl/dwl)** Wayland compositor, built from source with a Nix-generated `config.h` and patches (IPC, gaps, input config, layer popups, always-center, exclusive focus), plus `dwlmsg` for IPC
- **[mesa-shell](https://github.com/accmeboot/mesa-shell)** — a [Quickshell](https://quickshell.org/) bar/shell, wired into the dwl session via systemd
- **[Stylix](https://github.com/nix-community/stylix)** theming with dark/light specialisations; base16 schemes are retinted from the wallpaper (`scripts/retint.py`)
- **Neovim** with a Lua config using the built-in `vim.pack` plugin manager
- Ghostty, zsh, starship, tmux, yazi, fastfetch, hypridle

## Structure

```
.
├── flake.nix          # hosts and inputs
├── hosts/             # per-machine system + home config
│   ├── 7950x3d-xtx/   # NixOS desktop
│   ├── rog16/         # NixOS laptop (ASUS ROG, NVIDIA PRIME)
│   └── mbp-m1/        # macOS (nix-darwin)
├── config/            # NixOS system modules (system, dev, desktop, gaming, solaar, dwl)
├── home-manager/      # Home Manager modules and profiles (base, linux-desktop, macos)
├── scripts/           # screenshot, mpv and retint helpers
└── assets/            # fonts, wallpapers, showcase
```

## Usage

NixOS:

```sh
sudo nixos-rebuild switch --flake .#7950x3d-xtx   # or .#rog16
```

macOS (run `hosts/mbp-m1/boostrap.sh` first on a fresh machine):

```sh
sudo darwin-rebuild switch --flake .#mbp-m1
```

### Secrets & API Keys

Sensitive data (like API keys) should **not** be committed to the repo. Instead, store secrets in a `~/.env` file (sourced automatically by the zsh config) or use a password manager.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
