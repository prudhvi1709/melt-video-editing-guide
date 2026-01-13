# Speed Control with MELT

Learn how to create slow motion, fast forward, and reverse playback effects.

---

## Demo Video

<video width="100%" controls>
  <source src="https://github.com/prudhvi1709/melt-video-editing-guide/releases/download/v1.0.0/demo-speed-control.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Original clip played at 0.5x speed (slow motion), doubling the playback duration.

---

## Command Used

```bash
melt video.mp4 -filter timewarp speed=0.5 -consumer avformat:output.mp4
```

**Breakdown:**
- `video.mp4` - Source video file
- `-filter timewarp` - Speed control filter
- `speed=0.5` - Half speed (slow motion)
- Output duration: 2x original length

---

## Understanding Speed Control

The `timewarp` filter controls playback speed by changing the frame rate:

**Speed Values:**
| Speed | Effect | Duration | Use Case |
|-------|--------|----------|----------|
| 0.25 | Quarter speed | 4x longer | Ultra slow motion |
| 0.5 | Half speed | 2x longer | Dramatic slow motion |
| 0.75 | Three-quarter speed | 1.3x longer | Slight slow motion |
| 1.0 | Normal speed | Same | No change |
| 1.5 | 1.5x speed | 0.67x shorter | Faster pace |
| 2.0 | Double speed | Half length | Fast forward |
| 3.0 | Triple speed | One-third length | Very fast forward |
| 4.0 | Quadruple speed | Quarter length | Time-lapse effect |

---

## Variations

### Slow Motion (0.5x Speed)

```bash
melt video.mp4 -filter timewarp speed=0.5 \
  -consumer avformat:output-slow.mp4
```

Perfect for dramatic moments, sports replays, or emphasizing action.

---

### Fast Forward (2x Speed)

```bash
melt video.mp4 -filter timewarp speed=2.0 \
  -consumer avformat:output-fast.mp4
```

Great for time-lapse effects, speeding through boring parts, or comedic effect.

---

### Ultra Slow Motion (0.25x Speed)

```bash
melt video.mp4 -filter timewarp speed=0.25 \
  -consumer avformat:output-ultra-slow.mp4
```

Creates dramatic, cinematic slow motion. Output will be 4x the original duration.

---

### Variable Speed on Specific Segment

Apply speed control to only part of the video:

```bash
melt video.mp4 in=0 out=100 \
     video.mp4 in=100 out=200 -filter timewarp speed=0.5 \
     video.mp4 in=200 out=300 \
     -consumer avformat:output.mp4
```

**Result:** Normal speed → slow motion middle section → normal speed again.

---

## Reverse Playback

To play video in reverse, use the `reverse` filter:

```bash
melt video.mp4 -filter reverse \
  -consumer avformat:output-reverse.mp4
```

---

### Reverse + Slow Motion

Combine reverse and slow motion for dramatic effect:

```bash
melt video.mp4 -filter reverse -filter timewarp speed=0.5 \
  -consumer avformat:output-reverse-slow.mp4
```

---

## Audio Considerations

**Important:** Speed changes affect audio pitch.

### Preserve Audio Pitch

For speed changes with normal audio, extract and re-sync audio separately:

```bash
# Extract audio
ffmpeg -i video.mp4 audio.mp3

# Speed change video only (mute audio)
melt video.mp4 -filter timewarp speed=0.5 \
  -an \
  -consumer avformat:output-video-only.mp4

# Re-combine with original audio
ffmpeg -i output-video-only.mp4 -i audio.mp3 -c:v copy \
  -c:a aac -shortest output-final.mp4
```

### Mute Audio Entirely

If you don't want pitched audio:

```bash
melt video.mp4 -filter timewarp speed=0.5 \
  -an \
  -consumer avformat:output-silent.mp4
```

---

## Frame Interpolation

For smoother slow motion, consider:

1. **High frame rate source:** Shoot at 60fps or 120fps for best results
2. **Interpolation filters:** Use motion interpolation for frame blending
3. **Post-processing:** External tools like FFmpeg's minterpolate

---

## Tips

- **Source frame rate matters:** Higher frame rate video (60fps+) produces smoother slow motion
- **Test small segments:** Try speed on a 5-second clip before processing entire video
- **Avoid extreme speeds:** Values below 0.1 or above 10 may produce poor results
- **Audio becomes unusable:** Very slow or very fast speeds distort audio significantly
- **File size:** Slow motion increases file size proportionally (0.5x = 2x file size)
- **Processing time:** Slower speeds take longer to process

---

## Troubleshooting

**Problem:** Audio sounds distorted or "chipmunk-like"

**Solution:** Audio pitch changes with speed. Extract and re-add original audio, or mute with `-an`

---

**Problem:** Choppy slow motion playback

**Solution:** Source video frame rate too low. Use 60fps source for smooth slow motion, or reduce slowdown amount

---

**Problem:** Very large output file

**Solution:** Slow motion increases duration and file size. Compress with higher CRF: `crf=28` or `crf=30`

---

**Problem:** Output video is corrupted or won't play

**Solution:** Extreme speed values (< 0.1 or > 10) may cause issues. Use moderate speed changes

---

## Quick Reference

| Task | Command |
|------|---------|
| Slow motion (0.5x) | `melt video.mp4 -filter timewarp speed=0.5` |
| Fast forward (2x) | `melt video.mp4 -filter timewarp speed=2.0` |
| Ultra slow (0.25x) | `melt video.mp4 -filter timewarp speed=0.25` |
| Reverse | `melt video.mp4 -filter reverse` |
| Reverse + slow | `melt video.mp4 -filter reverse -filter timewarp speed=0.5` |
| Mute audio | Add `-an` before `-consumer` |

---

## Next Steps

- [Audio Fades →](06-audio-fades.md) - Control audio volume over time
- [Apply Filters →](02-filters.md) - Combine speed effects with visual filters
- [Trimming →](01-trimming.md) - Apply speed to specific segments
- [Batch Processing →](../examples/batch-processing.md) - Automate speed changes

---

[← Back to Demos](README.md)
