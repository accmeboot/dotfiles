#!/bin/bash

# Check if Nix is already installed
if command -v nix >/dev/null 2>&1; then
    echo "Nix is already installed"
else
    echo "Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install)
fi

# Enable flakes
echo "Enabling flakes..."
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

cat << 'EOF'

Nix installation complete! To setup your Darwin configuration:

1. First build and install the initial system:
   nix build .#darwinConfigurations.mbp-m1.system
   ./result/sw/bin/darwin-rebuild switch --flake .#mbp-m1

2. After installation completes:
   - Start a new shell or source your profile
   - You can safely remove the result directory: rm -rf result

3. For future updates, simply run:
   darwin-rebuild switch --flake .#mbp-m1

EOF
