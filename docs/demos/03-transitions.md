# Transitions with MELT

Create smooth transitions between video clips.

---

## Demo Video

<video width="100%" controls>
  <source src="https://github.com/prudhvi1709/melt-video-editing-guide/releases/download/v1.0.0/demo-transitions.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Two video clips smoothly blending together with a 25-frame luma dissolve transition.

---

## Basic Dissolve Transition

```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma \
  -consumer avformat:output.mp4
```

**What this does:**
- Takes two video clips
- Creates a 25-frame dissolve transition between them
- Uses `luma` mixer for smooth blend

---

## Understanding Transitions

**Transition Duration:**
- Specified in frames
- At 25fps: 25 frames = 1 second
- At 30fps: 30 frames = 1 second

**Common Durations:**
| Frames (25fps) | Duration | Use Case |
|----------------|----------|----------|
| 12-15 | 0.5s | Quick transition |
| 25-30 | 1s | Standard transition |
| 50-75 | 2-3s | Slow fade |

---

## Transition Types

### Luma Dissolve (Most Common)
```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma
```
Smooth crossfade between clips.

### Composite Transition
```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer composite
```
Blends clips with alpha channel support.

### Mix Audio and Video
```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma -mixer mix:-1
```
Transitions both video (luma) and audio (mix).

---

## Multiple Clips with Transitions

```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma \
     clip3.mp4 -mix 25 -mixer luma \
     clip4.mp4 -mix 25 -mixer luma \
     -consumer avformat:output.mp4
```

**Result:** Four clips with smooth transitions between each.

---

## Custom Transition Timing

### Different Transition Lengths
```bash
melt clip1.mp4 clip2.mp4 -mix 50 -mixer luma \
     clip3.mp4 -mix 15 -mixer luma \
     -consumer avformat:output.mp4
```

**Result:**
- 50-frame transition between clips 1 and 2 (slow fade)
- 15-frame transition between clips 2 and 3 (quick cut)

---

## Transition with Trimming

Combine trimming and transitions:

```bash
melt clip1.mp4 in=0 out=250 \
     clip2.mp4 in=50 out=300 -mix 25 -mixer luma \
     -consumer avformat:output.mp4
```

**Result:** Takes specific segments and transitions between them.

---

## Advanced Transitions

### Fade to Black
```bash
melt clip1.mp4 colour:black out=25 -mix 25 -mixer luma \
     -consumer avformat:output.mp4
```

### Fade from Black
```bash
melt colour:black out=25 clip1.mp4 -mix 25 -mixer luma \
     -consumer avformat:output.mp4
```

### Cross-dissolve Slideshow
```bash
melt img1.jpg out=100 \
     img2.jpg out=100 -mix 25 -mixer luma \
     img3.jpg out=100 -mix 25 -mixer luma \
     -consumer avformat:slideshow.mp4
```

---

## Audio Transitions

### Crossfade Audio Only
```bash
melt audio1.mp3 audio2.mp3 -mix 50 -mixer mix:-1 \
     -consumer avformat:output.mp3
```

### Audio Fade In
```bash
melt audio.mp3 -filter volume gain=0 end=1 in=0 out=50 \
     -consumer avformat:output.mp3
```

### Audio Fade Out
```bash
melt audio.mp3 -filter volume gain=1 end=0 in=950 out=1000 \
     -consumer avformat:output.mp3
```

---

## Query Available Transitions

```bash
melt -query transitions
```

Common transitions:
- `luma` - Crossfade/dissolve
- `mix` - Audio mixing
- `composite` - Alpha blending
- `region` - Region-based transition
- `affine` - Transform-based transition

---

## Tips

- **Match timing:** Ensure transition length feels natural
- **Audio sync:** Use `-mixer mix:-1` to transition audio with video
- **Test lengths:** Try 15, 25, and 50 frames to find best timing
- **Symmetry:** Use same transition length throughout for consistency

---

## Troubleshooting

**Problem:** Jerky transitions

**Solution:** Increase transition frame count (try 25 or 50 frames)

**Problem:** Audio cuts abruptly

**Solution:** Add audio mixer: `-mixer mix:-1`

**Problem:** Transition too slow

**Solution:** Reduce frame count (try 12-15 frames)

---

## Quick Reference

| Task | Command |
|------|---------|
| Basic dissolve | `melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma` |
| With audio | `melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma -mixer mix:-1` |
| Fade to black | `melt clip.mp4 colour:black out=25 -mix 25 -mixer luma` |
| Slideshow | `melt img*.jpg out=100 -mix 25 -mixer luma` |

---

## Next Steps

- [Add Watermarks →](04-watermarks.md) - Overlay text on transitions
- [Trimming Clips →](01-trimming.md) - Prepare clips for transitions
- [See All Transitions →](../reference/transitions.md) - Complete reference

---

[← Back to Demos](README.md)
