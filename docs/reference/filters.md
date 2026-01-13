# MELT Filters Reference

Complete reference of commonly used MELT filters.

---

## Query Filters

To see all available filters on your system:

```bash
melt -query filters
```

To filter the list:

```bash
melt -query filters | grep -i brightness
```

---

## Visual Filters

### brightness
Adjust brightness and contrast.

```bash
melt video.mp4 -filter brightness level=1.5
```

**Parameters:**
- `level` - Brightness multiplier (0.0 to 2.0+, default: 1.0)
- `in/out` - Frame range

---

### greyscale
Convert video to black and white.

```bash
melt video.mp4 -filter greyscale
```

**Parameters:** None

---

### sepia
Apply sepia tone (vintage brown tint).

```bash
melt video.mp4 -filter sepia
```

**Parameters:** None

---

### boxblur
Apply blur effect.

```bash
melt video.mp4 -filter boxblur hori=5 vert=5
```

**Parameters:**
- `hori` - Horizontal blur radius
- `vert` - Vertical blur radius

---

### vignette
Darken edges of frame (vignette effect).

```bash
melt video.mp4 -filter vignette
```

**Parameters:**
- `radius` - Effect radius
- `softness` - Edge softness

---

## Audio Filters

### volume
Adjust audio volume.

```bash
melt video.mp4 -filter volume gain=1.5
```

**Parameters:**
- `gain` - Volume multiplier (0.0 to 2.0+, default: 1.0)
- `limiter` - Prevent clipping (on/off)
- `in/out` - Frame range

---

### audiowave
Generate audio waveform visualization.

```bash
melt audio.mp3 -filter audiowave
```

---

## Transform Filters

### affine
Rotate, scale, and transform video.

```bash
melt video.mp4 -filter affine transition.rotate_x=90
```

**Parameters:**
- `rotate_x` - Rotation in degrees
- `scale_x` - Horizontal scale
- `scale_y` - Vertical scale

---

### mirror
Flip video horizontally or vertically.

```bash
melt video.mp4 -filter mirror reverse=1
```

**Parameters:**
- `reverse` - 1 for horizontal, 0 for vertical

---

### crop
Crop video to specific region.

```bash
melt video.mp4 -filter crop left=0 top=0 right=640 bottom=480
```

**Parameters:**
- `left` - Left edge position
- `top` - Top edge position
- `right` - Right edge position
- `bottom` - Bottom edge position
- `center` - Center crop (1/0)

---

## Color Filters

### lift_gamma_gain
Advanced color grading.

```bash
melt video.mp4 -filter lift_gamma_gain lift_r=1.1 lift_g=1.1 lift_b=1.1
```

**Parameters:**
- `lift_r/g/b` - Lift (shadows) per channel
- `gamma_r/g/b` - Gamma (midtones) per channel
- `gain_r/g/b` - Gain (highlights) per channel

---

### colour (color)
Generate solid color.

```bash
melt colour:red out=250
```

**Colors:** red, green, blue, white, black, yellow, cyan, magenta

---

## Overlay Filters

### watermark
Add text or image overlay.

```bash
melt video.mp4 -filter watermark:logo.png
melt video.mp4 -filter watermark:"+Text.txt"
```

**Parameters:**
- `composite.halign` - Horizontal alignment (left/center/right)
- `composite.valign` - Vertical alignment (top/middle/bottom)
- `composite.geometry` - Custom position (x%,y%,w%,h%)

---

## Motion Filters

### dance
Rhythm-based visual effect.

```bash
melt video.mp4 -filter dance
```

---

### wave
Wave distortion effect.

```bash
melt video.mp4 -filter wave
```

---

## Frame Filters

### oldfilm
Simulate old film with scratches and grain.

```bash
melt video.mp4 -filter oldfilm
```

---

### dust
Add dust particles effect.

```bash
melt video.mp4 -filter dust
```

---

## Combining Filters

Multiple filters applied in sequence:

```bash
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.2 \
  -filter vignette \
  -consumer avformat:output.mp4
```

---

## Filter Tips

1. **Test first:** Apply to short clip to preview
2. **Order matters:** Filter sequence affects result
3. **Performance:** More filters = slower processing
4. **Parameters:** Use `-query filters` for details
5. **Reversible:** Original file never modified

---

## Common Combinations

### Vintage Look
```bash
melt video.mp4 \
  -filter sepia \
  -filter vignette \
  -filter oldfilm
```

### High Contrast B&W
```bash
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.3
```

### Soft Bright
```bash
melt video.mp4 \
  -filter brightness level=1.2 \
  -filter boxblur hori=2 vert=2
```

---

[← Back to Demos](../demos/)
