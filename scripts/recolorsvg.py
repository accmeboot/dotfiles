#!/usr/bin/env python3
"""
SVG Icon Recoloring Script

Recolors SVG icons by mapping their colors to a base16 color palette.
Intelligently separates neutral colors (grays, whites, blacks) from accent colors
to preserve the intent of monochrome vs. colorful icons.

Usage:
    recolor-svg.py <base00> <base01> ... <base0F> < input.svg > output.svg

Arguments:
    16 base16 color scheme colors in hex format (#RRGGBB):
    - base00-base07: Neutral colors (backgrounds, foregrounds, grays)
    - base08-base0F: Accent colors (reds, greens, blues, etc.)

Algorithm:
    1. Detects if a source color is neutral:
       - Low saturation (< 25%) OR
       - Very dark (L < 0.3 and S < 0.6) OR very light (L > 0.85)
    2. For neutrals: maps based primarily on lightness
    3. For colorful: maps to base08-base0F by HUE first (strict hue matching),
       then by lightness and saturation
    4. Uses HLS color space distance for best color matching

Example:
    python3 recolor-svg.py \\
        "#11121d" "#212234" "#212234" "#353945" \\
        "#4a5057" "#a0a8cd" "#abb2bf" "#bcc2dc" \\
        "#ee6d85" "#f6955b" "#d7a65f" "#95c561" \\
        "#9fbbf3" "#7199ee" "#a485dd" "#773440" \\
        < input.svg > output.svg
"""

import sys
import re
import xml.etree.ElementTree as ET
from colorsys import rgb_to_hls
import math


def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple (0-1 range)."""
    hex_color = hex_color.lstrip("#")
    if len(hex_color) == 3:
        hex_color = "".join([c * 2 for c in hex_color])
    return tuple(int(hex_color[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


def rgb_to_hex(rgb):
    """Convert RGB tuple (0-1 range) to hex color."""
    return "#{:02x}{:02x}{:02x}".format(
        int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255)
    )


def hue_distance(h1, h2):
    """Calculate hue distance considering wrapping (0 and 1 are both red)."""
    return min(abs(h1 - h2), 1 - abs(h1 - h2))


def color_distance(rgb1, rgb2):
    """Calculate color distance using HLS space, heavily weighting hue."""
    h1, l1, s1 = rgb_to_hls(*rgb1)
    h2, l2, s2 = rgb_to_hls(*rgb2)

    dh = hue_distance(h1, h2)

    # Weight hue MUCH more heavily for accent colors
    return math.sqrt((dh * 5) ** 2 + (s1 - s2) ** 2 + (l1 - l2) ** 2 * 0.5)


def is_neutral(rgb, saturation_threshold=0.25):
    """
    Check if color should be treated as neutral.
    A color is neutral if:
    - Low saturation (< 25%) OR
    - Very dark (lightness < 30% with saturation < 60%) OR
    - Very light (lightness > 85%)
    """
    h, l, s = rgb_to_hls(*rgb)

    # Very dark colors with reasonable saturation are still neutral
    if l < 0.30 and s < 0.60:
        return True

    # Very light colors are always neutral
    if l > 0.85:
        return True

    # Otherwise check saturation
    return s < saturation_threshold


def map_neutral_color(rgb, neutral_palette):
    """Map neutral color based primarily on lightness."""
    h, l, s = rgb_to_hls(*rgb)

    if l < 0.15:
        candidates = neutral_palette[0:2]  # base00, base01
    elif l < 0.35:
        candidates = neutral_palette[1:4]  # base01, base02, base03
    elif l < 0.55:
        candidates = neutral_palette[3:6]  # base03, base04, base05
    elif l < 0.75:
        candidates = neutral_palette[5:7]  # base05, base06
    else:
        candidates = neutral_palette[5:8]  # base05, base06, base07

    # Find closest match by lightness
    min_distance = float("inf")
    best_match = candidates[0]

    for palette_color in candidates:
        palette_rgb = hex_to_rgb(palette_color)
        ph, pl, ps = rgb_to_hls(*palette_rgb)
        distance = abs(l - pl)

        if distance < min_distance:
            min_distance = distance
            best_match = palette_color

    return best_match


def map_accent_color(rgb, accent_palette):
    """Map colorful colors with strict hue matching, preferring muted tones."""
    h, l, s = rgb_to_hls(*rgb)

    # Darken bright source colors before matching (only affects L > 0.6)
    if l > 0.6:
        l = 0.6 + (l - 0.6) * 0.5  # Compress bright range

    # First pass: filter by hue proximity
    hue_threshold = 0.10 if s > 0.5 else 0.15

    hue_candidates = []
    for palette_color in accent_palette:
        palette_rgb = hex_to_rgb(palette_color)
        ph, pl, ps = rgb_to_hls(*palette_rgb)

        if hue_distance(h, ph) < hue_threshold:
            hue_candidates.append(palette_color)

    if hue_candidates:
        palette = hue_candidates
    else:
        palette = accent_palette

    # Find best match using adjusted lightness
    min_distance = float("inf")
    best_match = palette[0]

    for palette_color in palette:
        palette_rgb = hex_to_rgb(palette_color)
        ph, pl, ps = rgb_to_hls(*palette_rgb)

        dh = hue_distance(h, ph)
        distance = math.sqrt((dh * 5) ** 2 + (s - ps) ** 2 + (l - pl) ** 2 * 0.5)

        if distance < min_distance:
            min_distance = distance
            best_match = palette_color

    return best_match


def map_color_to_palette(color, neutral_palette, accent_palette):
    """Map a color to the closest match, separating neutrals from accents."""
    if not color:
        return color

    color = color.strip().lower()

    # Skip transparent/none/currentColor
    if color in ["none", "transparent", "currentcolor"]:
        return color

    # Parse hex color
    if color.startswith("#"):
        try:
            rgb = hex_to_rgb(color)

            if is_neutral(rgb):
                return map_neutral_color(rgb, neutral_palette)
            else:
                return map_accent_color(rgb, accent_palette)
        except:
            return color

    return color


def recolor_css(css_content, neutral_palette, accent_palette):
    """Recolor hex colors in CSS content."""

    def replace_hex(match):
        old_color = match.group(0)
        new_color = map_color_to_palette(old_color, neutral_palette, accent_palette)
        return new_color

    # Match hex colors in CSS
    pattern = r"#[0-9a-fA-F]{3,6}"
    return re.sub(pattern, replace_hex, css_content)


def recolor_svg(svg_content, neutral_palette, accent_palette):
    """Recolor SVG using color palette."""
    # Register namespaces to preserve them
    namespaces = {
        "": "http://www.w3.org/2000/svg",
        "xlink": "http://www.w3.org/1999/xlink",
    }

    for prefix, uri in namespaces.items():
        ET.register_namespace(prefix if prefix else "", uri)

    try:
        root = ET.fromstring(svg_content)
    except ET.ParseError as e:
        print(f"Error parsing SVG: {e}", file=sys.stderr)
        return svg_content

    # Find and process <style> tags
    for style_elem in root.findall(".//{http://www.w3.org/2000/svg}style"):
        if style_elem.text:
            style_elem.text = recolor_css(
                style_elem.text, neutral_palette, accent_palette
            )

    # Also check for style tags without namespace
    for style_elem in root.findall(".//style"):
        if style_elem.text:
            style_elem.text = recolor_css(
                style_elem.text, neutral_palette, accent_palette
            )

    # Attributes that can contain colors
    color_attrs = ["fill", "stroke", "stop-color", "flood-color", "lighting-color"]

    # Process all elements
    for elem in root.iter():
        # Process style attribute
        if "style" in elem.attrib:
            style = elem.attrib["style"]
            for attr in color_attrs:
                # Match color values in style (but not currentColor)
                pattern = f"{attr}:\\s*(#[0-9a-fA-F]{{3,6}})"

                def replace_color(match):
                    old_color = match.group(1)
                    new_color = map_color_to_palette(
                        old_color, neutral_palette, accent_palette
                    )
                    return f"{attr}:{new_color}"

                style = re.sub(pattern, replace_color, style)
            elem.attrib["style"] = style

        # Process direct attributes
        for attr in color_attrs:
            if attr in elem.attrib:
                old_color = elem.attrib[attr]
                new_color = map_color_to_palette(
                    old_color, neutral_palette, accent_palette
                )
                elem.attrib[attr] = new_color

    return ET.tostring(root, encoding="unicode")


if __name__ == "__main__":
    if len(sys.argv) < 17:
        print(
            "Usage: recolor-svg.py <base00> <base01> ... <base0F> < input.svg > output.svg",
            file=sys.stderr,
        )
        print("Expects 16 base16 colors in hex format: #RRGGBB", file=sys.stderr)
        sys.exit(1)

    # Split palette: base00-base07 are neutrals, base08-base0F are accents
    all_colors = [c if c.startswith("#") else f"#{c}" for c in sys.argv[1:17]]
    neutral_palette = all_colors[0:8]  # base00-base07
    accent_palette = all_colors[8:16]  # base08-base0F

    # Read SVG from stdin
    svg_content = sys.stdin.read()

    # Recolor and output
    recolored = recolor_svg(svg_content, neutral_palette, accent_palette)
    print(recolored)
