# Watermarks & Overlays with MELT

Add watermarks, text, and overlays to your videos.

---

## Demo Video

<video width="100%" controls>
  <source src="../../videos/demos/demo-watermarks.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Text watermark "Sample Watermark" positioned at the bottom center of the video.

---

## Text Watermark

```bash
melt video.mp4 \
  -filter watermark:"+Your Text Here.txt" \
    composite.halign=center \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

**What this does:**
- `+` prefix indicates text content (not filename)
- Text displayed at bottom center
- `.txt` extension required even for inline text

---

## Image Watermark

```bash
melt video.mp4 -filter watermark:logo.png \
  -consumer avformat:output.mp4
```

**Result:** Overlays logo.png on the video (default: top-left corner).

---

## Positioning Watermarks

### Bottom Right Corner
```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=right \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

### Center of Screen
```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=center \
    composite.valign=middle \
  -consumer avformat:output.mp4
```

### Custom Position (Percentage)
```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.geometry=10%,10%,20%,20% \
  -consumer avformat:output.mp4
```

**Parameters:** `x%, y%, width%, height%`

---

## Multi-line Text

Use tilde (`~`) for line breaks:

```bash
melt video.mp4 \
  -filter watermark:"+Line 1~Line 2~Line 3.txt" \
    composite.halign=center \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

---

## Picture-in-Picture (PiP)

Overlay a small video in corner:

```bash
melt main_video.mp4 \
  -filter watermark:overlay_video.mp4 \
    composite.geometry=70%,70%,25%,25% \
    composite.progressive=1 \
  -consumer avformat:output.mp4
```

**Result:** Small video in bottom-right (25% size).

---

## Alignment Options

**Horizontal (`halign`):**
- `left` - Left edge
- `center` - Horizontal center
- `right` - Right edge

**Vertical (`valign`):**
- `top` - Top edge
- `middle` - Vertical center
- `bottom` - Bottom edge

---

## Copyright Watermark

```bash
melt video.mp4 \
  -filter watermark:"+© 2026 Your Name.txt" \
    composite.halign=right \
    composite.valign=bottom \
    composite.geometry=0,0,300,50 \
  -consumer avformat:output.mp4
```

---

## Transparent Overlay

For PNG with transparency:

```bash
melt video.mp4 \
  -filter watermark:transparent_logo.png \
    composite.progressive=1 \
  -consumer avformat:output.mp4
```

---

## Timed Watermark

Show watermark only for specific frames:

```bash
melt video.mp4 \
  -filter watermark:logo.png in=0 out=100 \
  -consumer avformat:output.mp4
```

**Result:** Logo appears only in first 100 frames.

---

## Multiple Watermarks

Add multiple watermarks to same video:

```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=left composite.valign=top \
  -filter watermark:"+© 2026.txt" \
    composite.halign=right composite.valign=bottom \
  -consumer avformat:output.mp4
```

---

## Advanced Text Styling

MELT uses Pango markup for text. Create a text file with styling:

**watermark.txt:**
```xml
<span foreground="white" background="black" size="large">Your Text</span>
```

```bash
melt video.mp4 -filter watermark:watermark.txt \
  -consumer avformat:output.mp4
```

---

## Common Use Cases

### Tutorial Watermark
```bash
melt screencast.mp4 \
  -filter watermark:"+Tutorial by YourName.txt" \
    composite.halign=center composite.valign=top \
  -consumer avformat:output.mp4
```

### Timestamp Overlay
```bash
melt video.mp4 \
  -filter watermark:"+Recorded: 2026-01-13.txt" \
    composite.halign=left composite.valign=bottom \
  -consumer avformat:output.mp4
```

### Channel Logo
```bash
melt video.mp4 \
  -filter watermark:channel_logo.png \
    composite.halign=right composite.valign=top \
    composite.geometry=85%,5%,10%,10% \
  -consumer avformat:output.mp4
```

---

## Tips

- **Transparency:** Use PNG files with alpha channel for best results
- **Size matters:** Keep watermarks under 20% of screen for visibility
- **Contrast:** Ensure text is readable against video background
- **Positioning:** Test different positions to avoid covering important content

---

## Troubleshooting

**Problem:** Text not showing

**Solution:** Ensure you use `+` prefix and `.txt` extension

**Problem:** Watermark too large

**Solution:** Adjust geometry percentages or image size

**Problem:** Text hard to read

**Solution:** Add background or use contrasting colors

---

## Quick Reference

| Task | Command |
|------|---------|
| Simple text | `watermark:"+Text.txt"` |
| Image watermark | `watermark:logo.png` |
| Bottom right | `composite.halign=right composite.valign=bottom` |
| Custom position | `composite.geometry=x%,y%,w%,h%` |
| Multiple lines | Use `~` between lines |

---

## Next Steps

- [Apply Filters →](02-filters.md) - Combine watermarks with effects
- [Create Transitions →](03-transitions.md) - Watermark with transitions
- [Batch Processing →](../examples/batch-processing.md) - Automate watermarking

---

[← Back to Demos](README.md)
