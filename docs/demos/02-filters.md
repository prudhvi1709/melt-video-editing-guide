# Filters & Effects with MELT

Apply visual effects and filters to transform your videos.

---

## Demo 1: Grayscale Filter

<video width="100%" controls>
  <source src="https://github.com/prudhvi1709/melt-video-editing-guide/releases/download/v1.0.0/demo-filter-grayscale.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Original video converted to black and white (grayscale).

### Command

```bash
melt video.mp4 -filter greyscale -consumer avformat:output.mp4
```

**Breakdown:**
- `-filter greyscale` - Applies the grayscale filter to remove all color
- Works on entire video by default

---

## Demo 2: Brightness Adjustment

<video width="100%" controls>
  <source src="https://github.com/prudhvi1709/melt-video-editing-guide/releases/download/v1.0.0/demo-brightness.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Original video with 50% increased brightness.

### Command

```bash
melt video.mp4 -filter brightness level=1.5 -consumer avformat:output.mp4
```

**Breakdown:**
- `-filter brightness` - Apply brightness adjustment
- `level=1.5` - 150% of original brightness (1.0 = normal, 0.5 = darker, 2.0 = much brighter)

---

## Common Filters

### Sepia Tone
```bash
melt video.mp4 -filter sepia -consumer avformat:output.mp4
```

### Blur Effect
```bash
melt video.mp4 -filter boxblur -consumer avformat:output.mp4
```

### Adjust Contrast
```bash
melt video.mp4 -filter brightness level=1.2 -consumer avformat:output.mp4
```

### Volume Adjustment
```bash
melt video.mp4 -filter volume gain=1.5 -consumer avformat:output.mp4
```

---

## Multiple Filters

Chain multiple filters together:

```bash
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.2 \
  -filter sepia \
  -consumer avformat:output.mp4
```

**Result:** Video is converted to grayscale, then brightened, then sepia-toned.

---

## Filter on Specific Segment

Apply filter only to frames 0-100:

```bash
melt video.mp4 -filter brightness in=0 out=100 level=1.5 \
  -consumer avformat:output.mp4
```

---

## Advanced Filter Examples

### Vintage Film Look
```bash
melt video.mp4 \
  -filter sepia \
  -filter vignette \
  -filter oldfilm \
  -consumer avformat:output.mp4
```

### High Contrast Black & White
```bash
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.3 \
  -consumer avformat:output.mp4
```

### Soft and Bright
```bash
melt video.mp4 \
  -filter brightness level=1.2 \
  -filter boxblur \
  -consumer avformat:output.mp4
```

---

## Query Available Filters

List all available filters:

```bash
melt -query filters
```

Get details about a specific filter:

```bash
melt -query filters | grep brightness
```

---

## Filter Parameters

Most filters accept parameters to customize their behavior:

**Brightness:**
- `level` - Brightness multiplier (0.0 to 2.0+)
- `in/out` - Frame range to apply

**Volume:**
- `gain` - Volume multiplier (0.0 to 2.0+)
- `limiter` - Prevent clipping (on/off)

**Box Blur:**
- `hori` - Horizontal blur radius
- `vert` - Vertical blur radius

---

## Tips

- **Test first:** Apply filters to short clips to preview
- **Order matters:** Filter sequence affects final result
- **Performance:** More filters = slower processing
- **Reversible:** Original file is never modified

---

## Troubleshooting

**Problem:** Filter not found

**Solution:** Check available filters with `melt -query filters`

**Problem:** Video too dark/bright

**Solution:** Adjust `level` parameter incrementally (try 1.1, 1.2, 1.3...)

**Problem:** Processing too slow

**Solution:** Reduce number of filters or use faster preset

---

## Next Steps

- [Apply Transitions →](03-transitions.md) - Blend filtered clips
- [Add Watermarks →](04-watermarks.md) - Combine filters with overlays
- [See All Filters →](../reference/filters.md) - Complete filter reference

---

[← Back to Demos](README.md)
