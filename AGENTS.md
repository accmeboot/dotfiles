# Agent Guidelines for Dotfiles Repository

## Build/Test Commands
- **Build NixOS**: `sudo nixos-rebuild switch --flake .#7950x3d-xtx` or `sudo nixos-rebuild switch --flake .#rog16`
- **Build macOS**: `darwin-rebuild switch --flake .#mbp-m1`
- **Check flake**: `nix flake check`
- **Update flake**: `nix flake update`
- No traditional test suite; validation is done through successful builds

## Code Style

### Nix Files (.nix)
- Use 2-space indentation
- Follow declarative configuration patterns as seen in existing modules
- Organize with section headers using `#---...---#` style comments
- Use attribute sets with proper spacing: `{ pkgs, ... }:`
- Import paths are relative: `./path/to/module`
- Use `lib.mkOption` for custom options with proper type annotations
- Follow nixpkgs naming: kebab-case for options, camelCase for variables

### Shell Scripts (.sh)
- Use `#!/usr/bin/env bash` or `#!/bin/bash` shebang
- Follow existing patterns in `scripts/` directory
- Use proper error handling and variable quoting

## Security
- **CRITICAL**: Never commit secrets, API keys, or tokens to the repository
- Store sensitive data in `~/.env` (sourced automatically by shell config) or use a password manager
