# MELT Transitions Reference

Complete reference of MELT transitions for blending clips.

---

## Query Transitions

```bash
melt -query transitions
```

---

## Common Transitions

### luma
Crossfade/dissolve transition using luminance.

```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma
```

**Best for:** Standard video transitions, dissolves

---

### mix
Audio mixing transition.

```bash
melt audio1.mp3 audio2.mp3 -mix 50 -mixer mix:-1
```

**Best for:** Audio crossfades, volume transitions

---

### composite
Alpha channel blending.

```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer composite
```

**Best for:** Videos with transparency, overlays

---

### region
Region-based transition.

```bash
melt clip1.mp4 clip2.mp4 -transition region
```

**Best for:** Picture-in-picture effects

---

## Transition Duration

Duration specified in frames:

**At 25 fps:**
- 12 frames = 0.5 seconds (quick)
- 25 frames = 1 second (standard)
- 50 frames = 2 seconds (slow)
- 75 frames = 3 seconds (very slow)

**At 30 fps:**
- 15 frames = 0.5 seconds (quick)
- 30 frames = 1 second (standard)
- 60 frames = 2 seconds (slow)
- 90 frames = 3 seconds (very slow)

---

## Common Patterns

### Video + Audio Transition
```bash
melt clip1.mp4 clip2.mp4 \
  -mix 25 -mixer luma -mixer mix:-1
```

### Multiple Clips
```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma \
     clip3.mp4 -mix 25 -mixer luma \
     clip4.mp4 -mix 25 -mixer luma
```

### Varying Durations
```bash
melt clip1.mp4 clip2.mp4 -mix 50 -mixer luma \
     clip3.mp4 -mix 15 -mixer luma
```

---

## Special Transitions

### Fade to Black
```bash
melt clip.mp4 colour:black out=25 -mix 25 -mixer luma
```

### Fade from Black
```bash
melt colour:black out=25 clip.mp4 -mix 25 -mixer luma
```

### Fade to White
```bash
melt clip.mp4 colour:white out=25 -mix 25 -mixer luma
```

---

## Tips

- Match transition length to content pace
- Use shorter transitions (12-15 frames) for fast-paced content
- Use longer transitions (50+ frames) for cinematic feel
- Always transition audio with `-mixer mix:-1` if needed

---

[← Back to Reference](../reference/)
