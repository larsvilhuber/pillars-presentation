#!/usr/bin/env python3
"""Generate the five pillar puzzle diagrams from the source photograph.

The four per-pillar images must show a piece whose tabs and blanks actually
complement the hole it leaves behind, so the pieces are cut out of the real
photo rather than drawn or generated:

1. Isolate the wood region by colour (warm and bright against grey concrete).
2. Find the seam lines by *local* contrast. A global dark threshold does not
   work: the upper vertical seam is faint enough that the two top pieces merge
   into a single blob.
3. Label connected components of wood-minus-seams to get the four pieces, then
   hand the seam pixels themselves to the nearest piece via a distance
   transform. The four masks then partition the wood exactly along the seam
   midlines, so the pieces tile back together with no gap or overlap.
4. Composite at ~1.6x the final size and downsample, which antialiases the cut
   edges. Backgrounds are real concrete stitched from the puzzle-free strips
   above and below the puzzle in the source photo.

Quadrant to pillar mapping is reading order: a=top-left, b=top-right,
c=bottom-left, d=bottom-right. The source photo carries no labels, so this is
a convention, not something recovered from the image.

The 2x2 assembly sits at the same absolute position in all five outputs and
only the highlighted piece slides out, so the puzzle stays put when advancing
between pillar slides.

Usage:  python3 presentation/puzzles/build_pillars.py
"""

import numpy as np
from PIL import Image, ImageFilter
from pathlib import Path
from scipy import ndimage as ndi

HERE = Path(__file__).resolve().parent
SOURCE = HERE / "source-photo.png"
OUTDIR = HERE.parent / "images"

OUT_SIZE = (467, 381)   # final size of every generated diagram
WORK = (760, 620)       # working canvas, downsampled to OUT_SIZE at the end
PULL = 78               # how far a piece slides out, on the working canvas
PILLARS = {"a": "TL", "b": "TR", "c": "BL", "d": "BR"}


def load_pieces(path):
    """Return (piece sprites keyed by quadrant, puzzle width, puzzle height)."""
    src = Image.open(path).convert("RGB")
    a = np.asarray(src).astype(float)
    lum = a.mean(2)
    warm = a[..., 0] - a[..., 2]

    # Wood: warm and bright, versus the grey concrete background.
    wood = (warm > 14) & (lum > 120)
    wood = ndi.binary_fill_holes(ndi.binary_closing(wood, np.ones((3, 3))))
    lab, n = ndi.label(wood)
    wood = lab == (np.argmax(ndi.sum(wood, lab, range(1, n + 1))) + 1)

    # Seams: darker than their local neighbourhood, not darker than a fixed cut.
    seam = wood & (lum < ndi.uniform_filter(lum, 21) - 8)
    core = wood & ~ndi.binary_dilation(seam, np.ones((3, 3)))
    lab, n = ndi.label(core)
    sizes = ndi.sum(core, lab, range(1, n + 1))
    seed = np.zeros_like(lab)
    for k, l in enumerate(np.argsort(sizes)[::-1][:4], 1):
        seed[lab == l + 1] = k

    # Give each seam pixel to the nearest piece: an exact partition of the wood.
    _, (iy, ix) = ndi.distance_transform_edt(seed == 0, return_indices=True)
    part = np.where(wood, seed[iy, ix], 0)

    # Name the pieces by where their centroids fall.
    cent = {k: np.nonzero(part == k)[::-1] for k in range(1, 5)}
    cent = {k: (xx.mean(), yy.mean()) for k, (xx, yy) in cent.items()}
    cx = np.mean([c[0] for c in cent.values()])
    cy = np.mean([c[1] for c in cent.values()])

    ys, xs = np.nonzero(wood)
    x0, x1, y0, y1 = xs.min(), xs.max() + 1, ys.min(), ys.max() + 1

    sprites = {}
    for k, (x, y) in cent.items():
        quad = ("T" if y < cy else "B") + ("L" if x < cx else "R")
        alpha = ((part == k) * 255).astype(np.uint8)
        rgba = np.dstack([a.astype(np.uint8), alpha])[y0:y1, x0:x1]
        sprites[quad] = Image.fromarray(rgba)
    return sprites, x1 - x0, y1 - y0


def concrete_background(path, size):
    """Stitch a background from the two puzzle-free concrete strips."""
    src = Image.open(path).convert("RGB")
    top = np.asarray(src.crop((0, 8, src.width, 198))).astype(float)
    bot = np.asarray(src.crop((0, 572, src.width, src.height))).astype(float)
    fade = 20
    w = np.linspace(0, 1, fade)[:, None, None]
    joined = np.vstack([top[:-fade], top[-fade:] * (1 - w) + bot[:fade] * w, bot[fade:]])

    tile = Image.fromarray(joined.astype(np.uint8))
    bg = tile.resize((size[0], round(size[0] * tile.height / tile.width)), Image.LANCZOS)
    if bg.height < size[1]:
        return bg.resize(size, Image.LANCZOS)
    top_crop = (bg.height - size[1]) // 2
    return bg.crop((0, top_crop, size[0], top_crop + size[1]))


def drop_shadow(canvas, sprite, pos):
    """Soft shadow matching the light direction in the source photo."""
    shade = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    shade.paste(Image.new("RGBA", sprite.size, (40, 36, 32, 120)),
                (pos[0] + 5, pos[1] + 8), sprite)
    return Image.alpha_composite(canvas, shade.filter(ImageFilter.GaussianBlur(7)))


def compose(bg, sprites, origin, pulled):
    """Assembled puzzle with one quadrant (or none) slid out diagonally."""
    offsets = {"TL": (-PULL, -PULL), "TR": (PULL, -PULL),
               "BL": (-PULL, PULL), "BR": (PULL, PULL)}
    place = {q: origin for q in sprites}
    if pulled:
        dx, dy = offsets[pulled]
        place[pulled] = (origin[0] + dx, origin[1] + dy)

    canvas = bg.convert("RGBA").copy()
    for q in sprites:                       # every shadow first, then every piece,
        canvas = drop_shadow(canvas, sprites[q], place[q])
    for q in sprites:                       # so no shadow lands on top of wood
        canvas.paste(sprites[q], place[q], sprites[q])
    return canvas.convert("RGB").resize(OUT_SIZE, Image.LANCZOS)


def main():
    sprites, pw, ph = load_pieces(SOURCE)
    bg = concrete_background(SOURCE, WORK)
    origin = ((WORK[0] - pw) // 2, (WORK[1] - ph) // 2)

    for name, quad in list(PILLARS.items()) + [("all", None)]:
        out = OUTDIR / f"pillars-diagram-{name}.png"
        compose(bg, sprites, origin, quad).save(out)
        print(f"wrote {out.relative_to(HERE.parent.parent)}")


if __name__ == "__main__":
    main()
