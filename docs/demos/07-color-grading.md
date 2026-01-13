# Color Grading with MELT

Learn how to perform professional color grading using lift-gamma-gain controls.

---

## Demo Video

<video width="100%" controls>
  <source src="https://github.com/prudhvi1709/melt-video-editing-guide/releases/download/v1.0.0/demo-color-grading.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Video with warm cinematic color grade applied - enhanced reds and oranges, slightly desaturated blues.

---

## Command Used

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.05 lift_g=1.0 lift_b=0.95 \
    gamma_r=1.0 gamma_g=0.98 gamma_b=0.95 \
    gain_r=1.1 gain_g=1.05 gain_b=0.9 \
  -consumer avformat:output.mp4
```

**Breakdown:**
- `lift_gamma_gain` - Professional color grading filter
- `lift_r/g/b` - Adjusts shadows (dark areas)
- `gamma_r/g/b` - Adjusts midtones (middle brightness)
- `gain_r/g/b` - Adjusts highlights (bright areas)
- Values > 1.0 brighten, < 1.0 darken
- Each channel (red, green, blue) controlled independently

---

## Understanding Lift-Gamma-Gain

**Three-Way Color Correction:**

| Control | Affects | Range | Use Case |
|---------|---------|-------|----------|
| **Lift** | Shadows (dark areas) | 0.0 - 2.0+ | Brighten/darken blacks, add color to shadows |
| **Gamma** | Midtones (middle brightness) | 0.0 - 2.0+ | Adjust overall brightness, contrast |
| **Gain** | Highlights (bright areas) | 0.0 - 2.0+ | Brighten/darken whites, add color to highlights |

**Parameter Values:**
- `1.0` = No change (neutral)
- `< 1.0` = Darken/reduce that color channel
- `> 1.0` = Brighten/increase that color channel
- `0.8-1.2` = Subtle adjustments
- `0.5-1.5` = Noticeable changes
- `0.0-2.0+` = Extreme grading

---

## Color Grading Presets

### Warm Cinematic Look

Teal shadows, orange highlights (popular "Hollywood" look):

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.05 lift_g=1.0 lift_b=0.95 \
    gamma_r=1.0 gamma_g=0.98 gamma_b=0.95 \
    gain_r=1.1 gain_g=1.05 gain_b=0.9 \
  -consumer avformat:output.mp4
```

**Effect:** Warm oranges in highlights, slightly cool shadows.

---

### Cool Blue Tone

Modern, clinical look:

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.95 lift_g=0.98 lift_b=1.05 \
    gamma_r=0.98 gamma_g=1.0 gamma_b=1.02 \
    gain_r=0.9 gain_g=0.95 gain_b=1.1 \
  -consumer avformat:output.mp4
```

**Effect:** Cool, blue-tinted overall look.

---

### High Contrast Look

Dramatic shadows and highlights:

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.8 lift_g=0.8 lift_b=0.8 \
    gamma_r=1.0 gamma_g=1.0 gamma_b=1.0 \
    gain_r=1.2 gain_g=1.2 gain_b=1.2 \
  -consumer avformat:output.mp4
```

**Effect:** Crushed blacks, boosted highlights.

---

### Film-Style Grade

Slightly faded, vintage feel:

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.1 lift_g=1.1 lift_b=1.1 \
    gamma_r=1.05 gamma_g=1.05 gamma_b=1.05 \
    gain_r=0.95 gain_g=0.95 gain_b=0.95 \
  -consumer avformat:output.mp4
```

**Effect:** Lifted blacks (faded), slightly compressed highlights.

---

### Natural Enhancement

Subtle improvements without obvious grading:

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.02 lift_g=1.02 lift_b=1.02 \
    gamma_r=1.05 gamma_g=1.05 gamma_b=1.05 \
    gain_r=1.0 gain_g=1.0 gain_b=1.0 \
  -consumer avformat:output.mp4
```

**Effect:** Slightly brighter, more vibrant, natural look.

---

## Adjusting Individual Tones

### Brighten Shadows Only

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.2 lift_g=1.2 lift_b=1.2 \
  -consumer avformat:output.mp4
```

**Use case:** Recover detail from dark areas.

---

### Adjust Midtones Only

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    gamma_r=1.15 gamma_g=1.15 gamma_b=1.15 \
  -consumer avformat:output.mp4
```

**Use case:** Overall brightness adjustment without affecting extremes.

---

### Control Highlights Only

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    gain_r=0.9 gain_g=0.9 gain_b=0.9 \
  -consumer avformat:output.mp4
```

**Use case:** Reduce overexposure, tame bright areas.

---

## Color Tinting

### Orange Tint (Warm Sunset)

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.1 lift_g=1.0 lift_b=0.9 \
    gamma_r=1.1 gamma_g=1.0 gamma_b=0.95 \
    gain_r=1.15 gain_g=1.05 gain_b=0.85 \
  -consumer avformat:output.mp4
```

---

### Blue/Cyan Tint (Night Scene)

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.85 lift_g=0.95 lift_b=1.1 \
    gamma_r=0.9 gamma_g=0.95 gamma_b=1.05 \
    gain_r=0.9 gain_g=0.95 gain_b=1.1 \
  -consumer avformat:output.mp4
```

---

### Green Tint (Matrix Style)

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.8 lift_g=1.1 lift_b=0.8 \
    gamma_r=0.85 gamma_g=1.1 gamma_b=0.85 \
    gain_r=0.8 gain_g=1.15 gain_b=0.8 \
  -consumer avformat:output.mp4
```

---

## Combining with Other Filters

### Color Grade + Brightness

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.05 lift_g=1.0 lift_b=0.95 \
    gamma_r=1.0 gamma_g=0.98 gamma_b=0.95 \
    gain_r=1.1 gain_g=1.05 gain_b=0.9 \
  -filter brightness level=1.1 \
  -consumer avformat:output.mp4
```

---

### Color Grade + Contrast

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.9 lift_g=0.9 lift_b=0.9 \
    gamma_r=1.0 gamma_g=1.0 gamma_b=1.0 \
    gain_r=1.1 gain_g=1.1 gain_b=1.1 \
  -consumer avformat:output.mp4
```

---

## Tips

- **Start subtle:** Begin with small adjustments (1.0 ± 0.1) and gradually increase
- **Watch scopes:** Use waveform/vectorscope monitors if available for accurate grading
- **Reference images:** Keep reference photos of your desired look nearby
- **Work in order:** Adjust lift → gamma → gain in that sequence
- **Test on different displays:** Check your grade on multiple screens
- **Avoid clipping:** Values below 0.5 or above 1.5 per channel may clip
- **Save presets:** Document successful grades for reuse

---

## Troubleshooting

**Problem:** Colors look unrealistic or over-saturated

**Solution:** Reduce adjustment amounts. Stay within 0.8-1.2 range for natural looks

---

**Problem:** Blacks are crushed (pure black with no detail)

**Solution:** Increase `lift_r`, `lift_g`, `lift_b` values above 1.0 to lift shadows

---

**Problem:** Highlights are blown out (pure white)

**Solution:** Decrease `gain_r`, `gain_g`, `gain_b` values below 1.0 to compress highlights

---

**Problem:** Skin tones look wrong

**Solution:** Be careful with red/orange channels. Keep `lift_r`, `gamma_r`, `gain_r` close to 1.0

---

**Problem:** Uneven color cast

**Solution:** Adjust individual RGB channels. If too blue, reduce `*_b` values

---

## Quick Reference

| Look | Lift | Gamma | Gain |
|------|------|-------|------|
| Warm/Orange | R↑ B↓ | R↑ B↓ | R↑ G↑ B↓ |
| Cool/Blue | R↓ B↑ | R↓ B↑ | R↓ B↑ |
| High Contrast | All ↓ | Neutral | All ↑ |
| Faded/Film | All ↑ | Slight ↑ | All ↓ |
| Natural Enhance | Slight ↑ | Slight ↑ | Neutral |

**Legend:** ↑ = increase (>1.0), ↓ = decrease (<1.0), R=red, G=green, B=blue

---

## Advanced Workflow

1. **Correct exposure:** Use `brightness` filter first if needed
2. **Balance colors:** Neutralize unwanted color casts
3. **Apply creative grade:** Add your desired look with lift-gamma-gain
4. **Fine-tune:** Make small adjustments to perfect the grade
5. **Compare:** Toggle between original and graded using `-before` and `-after` exports

---

## Next Steps

- [Apply Filters →](02-filters.md) - Combine color grading with other effects
- [Brightness Adjustments →](02-filters.md#brightness) - Basic exposure control
- [See All Filters →](../reference/filters.md) - More color correction options
- [Batch Processing →](../examples/batch-processing.md) - Apply grades to multiple videos

---

[← Back to Demos](README.md)
