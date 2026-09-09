# Puzzle diagram pipeline

Generates the five `pillars-diagram-*.png` images in `presentation/images/`.

- `source-photo.png` — the original photograph of the assembled wooden puzzle.
  This is the only hand-made input; do not overwrite it with a generated image.
- `build_pillars.py` — cuts the four pieces out of the photo and re-composites
  them.

```sh
python3 -m pip install -r presentation/puzzles/requirements.txt
python3 presentation/puzzles/build_pillars.py
```

Outputs, all 467x381:

| file | shows |
| --- | --- |
| `pillars-diagram-all.png` | all four pieces assembled |
| `pillars-diagram-a.png` | top-left piece slid out |
| `pillars-diagram-b.png` | top-right piece slid out |
| `pillars-diagram-c.png` | bottom-left piece slid out |
| `pillars-diagram-d.png` | bottom-right piece slid out |

## Why a script instead of hand-made images

The per-pillar images were previously generated independently, so the loose
piece did not fit the hole it left behind. Here the pieces are segmented out of
the real photo — wood found by colour, seams by local contrast, seam pixels
assigned to the nearest piece by a distance transform — so the four masks
partition the wood exactly along the seam midlines and the pieces tile back
together perfectly. See the docstring in `build_pillars.py` for detail.

## Conventions worth knowing before editing

- Pillar-to-quadrant mapping is reading order (a=TL, b=TR, c=BL, d=BR). The
  photo carries no labels, so this is a convention; change `PILLARS` to remap.
- The 2x2 assembly sits at the same absolute position in all five outputs, and
  only the highlighted piece moves. Advancing between pillar slides therefore
  leaves the puzzle in place, which pairs well with `transition=fade`.
- `PULL` sets how far a piece slides out, on the pre-downsample working canvas.
