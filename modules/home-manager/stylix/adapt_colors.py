#!/usr/bin/env python3
"""
Adapt a base16 color scheme to match a wallpaper's color palette.

This script extracts dominant colors from a wallpaper image and shifts
the hue and saturation of a base color scheme to harmonize with the wallpaper
while preserving the original scheme's contrast and color relationships.
"""
import sys
import json
from colorsys import rgb_to_hls, hls_to_rgb
from PIL import Image

# Tuning parameters
SATURATION_BLEND = 0.3  # How much to adjust saturation (0 = no change, 1 = full match)
MIN_SATURATION_THRESHOLD = 0.15  # What counts as a "color" vs grayscale
NUM_DOMINANT_COLORS = 8  # Number of dominant colors to extract from wallpaper


def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple (0-1 range)"""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) / 255.0 for i in (0, 2, 4))


def rgb_to_hex(rgb):
    """Convert RGB tuple (0-1 range) to hex color"""
    return '#{:02x}{:02x}{:02x}'.format(
        int(rgb[0] * 255),
        int(rgb[1] * 255),
        int(rgb[2] * 255)
    )


def get_color_palette(image_path):
    """Extract dominant colors from image using k-means-like clustering"""
    img = Image.open(image_path)
    img = img.convert('RGB')
    img = img.resize((150, 150))

    # Quantize to get dominant colors
    img_quantized = img.quantize(colors=NUM_DOMINANT_COLORS, method=2)
    palette = img_quantized.getpalette()[:NUM_DOMINANT_COLORS*3]

    # Convert palette to list of RGB tuples
    colors = []
    for i in range(0, len(palette), 3):
        r, g, b = palette[i]/255.0, palette[i+1]/255.0, palette[i+2]/255.0
        h, l, s = rgb_to_hls(r, g, b)
        if s > MIN_SATURATION_THRESHOLD:  # Filter out near-grayscale
            colors.append((h, l, s))

    return colors


def get_dominant_hue_and_saturation(image_path):
    """Extract dominant hue and average saturation from image"""
    colors = get_color_palette(image_path)

    if not colors:
        return 0.0, 0.5

    # Weight by saturation (more saturated colors have more influence)
    weighted_hue = sum(h * s for h, l, s in colors) / sum(s for h, l, s in colors)
    avg_saturation = sum(s for h, l, s in colors) / len(colors)

    return weighted_hue, avg_saturation


def adapt_color(hex_color, hue_shift, saturation_factor):
    """Shift color hue and adjust saturation"""
    r, g, b = hex_to_rgb(hex_color)
    h, l, s = rgb_to_hls(r, g, b)

    # Only shift if color has significant saturation
    if s > 0.1:
        # Apply hue shift
        h = (h + hue_shift) % 1.0

        # Adjust saturation to match wallpaper's saturation level
        # Use a gentler adjustment to preserve color relationships
        s = s * ((1.0 - SATURATION_BLEND) + SATURATION_BLEND * saturation_factor)
        s = min(1.0, max(0.0, s))

    r, g, b = hls_to_rgb(h, l, s)
    return rgb_to_hex((r, g, b))


def adapt_scheme(scheme, wallpaper_path):
    """Adapt color scheme to wallpaper"""
    wallpaper_hue, wallpaper_sat = get_dominant_hue_and_saturation(wallpaper_path)

    # Get base hue from base0D (primary color)
    base_rgb = hex_to_rgb(scheme['base0D'])
    base_h, _, base_s = rgb_to_hls(*base_rgb)

    hue_shift = wallpaper_hue - base_h

    # Calculate saturation adjustment factor
    saturation_factor = wallpaper_sat / base_s if base_s > 0 else 1.0

    # Adapt all colors
    adapted = {}
    for key, color in scheme.items():
        adapted[key] = adapt_color(color, hue_shift, saturation_factor)

    return adapted


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: adapt-colors.py <scheme.json> <wallpaper.png>", file=sys.stderr)
        sys.exit(1)

    scheme_path = sys.argv[1]
    wallpaper_path = sys.argv[2]

    with open(scheme_path, 'r') as f:
        scheme = json.load(f)

    adapted = adapt_scheme(scheme, wallpaper_path)

    # Output as Nix attrset
    print("{")
    for key, value in adapted.items():
        print(f'  {key} = "{value}";')
    print("}")
