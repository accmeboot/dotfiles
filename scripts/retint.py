#!/usr/bin/env python3
import argparse
import math
import sys

import numpy as np
from PIL import Image

LMS_FROM_LRGB = np.array([
    [0.4122214708, 0.5363325363, 0.0514459929],
    [0.2119034982, 0.6806995451, 0.1073969566],
    [0.0883024619, 0.2817188376, 0.6299787005],
])
OKLAB_FROM_LMS = np.array([
    [0.2104542553, 0.7936177850, -0.0040720468],
    [1.9779984951, -2.4285922050, 0.4505937099],
    [0.0259040371, 0.7827717662, -0.8086757660],
])
LMS_FROM_OKLAB = np.array([
    [1.0, 0.3963377774, 0.2158037573],
    [1.0, -0.1055613458, -0.0638541728],
    [1.0, -0.0894841775, -1.2914855480],
])
LRGB_FROM_LMS = np.array([
    [4.0767416621, -3.3077115913, 0.2309699292],
    [-1.2684380046, 2.6097574011, -0.3413193965],
    [-0.0041960863, -0.7034186147, 1.7076147010],
])

RAMP = [f"base0{i}" for i in "01234567"]


def srgb_to_linear(c):
    return np.where(c <= 0.04045, c / 12.92, ((c + 0.055) / 1.055) ** 2.4)


def linear_to_srgb(c):
    return np.where(c <= 0.0031308, c * 12.92, 1.055 * np.abs(c) ** (1 / 2.4) - 0.055)


def srgb_to_oklab(rgb):
    lms = srgb_to_linear(rgb) @ LMS_FROM_LRGB.T
    return np.cbrt(lms) @ OKLAB_FROM_LMS.T


def oklab_to_srgb(lab):
    lms = (lab @ LMS_FROM_OKLAB.T) ** 3
    return linear_to_srgb(lms @ LRGB_FROM_LMS.T)


def to_lch(lab):
    L, a, b = lab[..., 0], lab[..., 1], lab[..., 2]
    return L, np.hypot(a, b), np.arctan2(b, a)


def from_lch(L, C, h):
    return np.stack([L, C * np.cos(h), C * np.sin(h)], axis=-1)


def _in_gamut(L, C, h):
    rgb = oklab_to_srgb(from_lch(np.array(L), np.array(C), np.array(h)))
    return bool(np.all(rgb >= -1e-4) and np.all(rgb <= 1 + 1e-4))


def clip_to_srgb(L, C, h):
    lo, hi = 0.0, float(C)
    if _in_gamut(L, hi, h):
        return oklab_to_srgb(from_lch(np.array(L), np.array(hi), np.array(h)))
    for _ in range(24):
        mid = (lo + hi) / 2
        if _in_gamut(L, mid, h):
            lo = mid
        else:
            hi = mid
    return oklab_to_srgb(from_lch(np.array(L), np.array(lo), np.array(h)))


def image_tone(path, size=128):
    img = Image.open(path).convert("RGB").resize((size, size), Image.LANCZOS)
    rgb = np.asarray(img, dtype=np.float64).reshape(-1, 3) / 255.0
    L, C, h = to_lch(srgb_to_oklab(rgb))

    keep = (L > 0.10) & (L < 0.95) & (C > 0.01)
    if not keep.any():
        return None, 0.0
    L, C, h = L[keep], C[keep], h[keep]

    w = C ** 2
    hue = math.atan2(float(np.sum(w * np.sin(h))), float(np.sum(w * np.cos(h))))
    chroma = float(np.sum(w * C) / np.sum(w))
    return hue, chroma


def rotate_toward(h, target, max_rad):
    delta = (target - h + math.pi) % (2 * math.pi) - math.pi
    return h + math.copysign(min(abs(delta), max_rad), delta)


def retint(scheme, hue, chroma, tint, rotate_deg, max_ramp_chroma):
    out = {}
    rotate_rad = math.radians(rotate_deg)
    for slot, hexstr in scheme.items():
        rgb = np.array([int(hexstr[i:i + 2], 16) / 255.0 for i in (0, 2, 4)])
        L, C, h = (float(v) for v in to_lch(srgb_to_oklab(rgb)))

        if hue is None:
            out[slot] = hexstr
            continue

        if slot in RAMP:
            C2 = max(C, min(tint * chroma, max_ramp_chroma))
            h2 = rotate_toward(h, hue, rotate_rad) if C > max_ramp_chroma else hue
        else:
            h2 = rotate_toward(h, hue, rotate_rad)
            C2 = C

        srgb = clip_to_srgb(L, C2, h2)
        out[slot] = "".join(
            f"{int(round(min(max(float(v), 0.0), 1.0) * 255)):02X}" for v in srgb
        )
    return out


def read_scheme(path):
    meta, palette = {}, {}
    for line in open(path):
        line = line.strip()
        if not line or line.startswith("#") or line == "palette:":
            continue
        key, _, val = line.partition(":")
        val = val.strip().strip('"').strip("'")
        key = key.strip()
        if key.startswith("base") and len(key) == 6:
            palette[key] = val.lstrip("#").upper()
        else:
            meta[key] = val
    return meta, palette


def main():
    p = argparse.ArgumentParser(
        description="Retint a base16 scheme toward the tone of an image.")
    p.add_argument("--scheme", required=True, help="base16 YAML to retint")
    p.add_argument("--image", required=True, help="image to take the tone from")
    p.add_argument("--rotate", type=float, default=15.0,
                   help="max accent hue rotation, degrees (default: 15)")
    p.add_argument("--tint", type=float, default=0.15,
                   help="fraction of the image chroma the greyscale ramp takes "
                        "on, 0..1 (default: 0.15)")
    p.add_argument("--max-ramp-chroma", type=float, default=0.030,
                   help="hard ceiling on ramp chroma in Oklch (default: 0.030)")
    p.add_argument("--report", action="store_true",
                   help="write a before/after table to stderr")
    args = p.parse_args()

    meta, palette = read_scheme(args.scheme)
    hue, chroma = image_tone(args.image)
    tinted = retint(palette, hue, chroma, args.tint, args.rotate,
                    args.max_ramp_chroma)

    if args.report:
        deg = "n/a" if hue is None else f"{math.degrees(hue) % 360:6.1f}°"
        print(f"image hue {deg}   mean chroma {chroma:.4f}", file=sys.stderr)
        for slot in palette:
            mark = "ramp  " if slot in RAMP else "accent"
            print(f"  {slot} {mark}  #{palette[slot]} -> #{tinted[slot]}",
                  file=sys.stderr)

    name = meta.get("name", "scheme")
    print('system: "base16"')
    print(f'name: "{name} (retinted)"')
    print(f'author: "{meta.get("author", "")}"')
    print(f'variant: "{meta.get("variant", "dark")}"')
    print("palette:")
    for slot, val in tinted.items():
        print(f'  {slot}: "#{val.lower()}"')


if __name__ == "__main__":
    main()
