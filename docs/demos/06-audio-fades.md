# Audio Fading with MELT

Learn how to create smooth audio fade in and fade out effects.

---

## Demo Video

<video width="100%" controls>
  <source src="../../videos/demos/demo-audio-fades.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** Video with audio fading in during the first 3 seconds and fading out during the last 3 seconds.

---

## Command Used

```bash
melt video.mp4 in=0 out=250 \
  -filter volume gain=0 end=1 in=0 out=75 \
  -filter volume gain=1 end=0 in=175 out=250 \
  -consumer avformat:output.mp4 vcodec=libx264 acodec=aac
```

**Breakdown:**
- First `-filter volume`: Fade in from silence (gain=0) to full volume (end=1) over frames 0-75
- Second `-filter volume`: Fade out from full volume (gain=1) to silence (end=0) over frames 175-250
- `gain=0`: Starting volume (0 = silent)
- `end=1`: Ending volume (1 = full volume)
- `in=0 out=75`: Apply fade to frames 0-75 (first 3 seconds at 25fps)

---

## Understanding Audio Fades

**Volume Gain Values:**
- `0.0` = Silent (0% volume)
- `0.5` = Half volume (50%)
- `1.0` = Full volume (100%)
- `1.5` = 150% volume (may cause distortion)

**Fade Duration at Different Frame Rates:**

### At 25 fps:
| Frames | Duration | Use Case |
|--------|----------|----------|
| 25 | 1 second | Quick fade |
| 50 | 2 seconds | Standard fade |
| 75 | 3 seconds | Smooth fade |
| 125 | 5 seconds | Long, gradual fade |

### At 30 fps:
| Frames | Duration | Use Case |
|--------|----------|----------|
| 30 | 1 second | Quick fade |
| 60 | 2 seconds | Standard fade |
| 90 | 3 seconds | Smooth fade |
| 150 | 5 seconds | Long, gradual fade |

---

## Fade In Only

Start from silence and fade to full volume:

```bash
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=75 \
  -consumer avformat:output.mp4
```

**Result:** Audio fades in over first 3 seconds (75 frames at 25fps), then plays at full volume.

---

## Fade Out Only

Start at full volume and fade to silence:

```bash
melt video.mp4 \
  -filter volume gain=1 end=0 in=175 out=250 \
  -consumer avformat:output.mp4
```

**Result:** Audio plays at full volume, then fades out over last 3 seconds.

---

## Fade In and Out (Complete)

Combine both fades for smooth start and end:

```bash
melt video.mp4 in=0 out=250 \
  -filter volume gain=0 end=1 in=0 out=75 \
  -filter volume gain=1 end=0 in=175 out=250 \
  -consumer avformat:output.mp4
```

**Result:** 3-second fade in, full volume middle section, 3-second fade out.

---

## Quick Fade (1 Second)

For faster fades:

```bash
# 1-second fade in at 25fps
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=25 \
  -consumer avformat:output.mp4
```

---

## Long Fade (5 Seconds)

For gradual, cinematic fades:

```bash
# 5-second fade in at 25fps
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=125 \
  -consumer avformat:output.mp4
```

---

## Audio Crossfade Between Clips

Fade out first clip while fading in second clip:

```bash
melt clip1.mp4 -filter volume gain=1 end=0 in=200 out=250 \
     clip2.mp4 -filter volume gain=0 end=1 in=0 out=50 \
     -consumer avformat:output.mp4
```

**Alternative using transitions:**

```bash
melt clip1.mp4 clip2.mp4 \
  -mix 50 -mixer luma -mixer mix:-1 \
  -consumer avformat:output.mp4
```

The `-mixer mix:-1` creates audio crossfade automatically.

---

## Fade to Specific Volume Level

Fade from silence to 50% volume:

```bash
melt video.mp4 \
  -filter volume gain=0 end=0.5 in=0 out=75 \
  -consumer avformat:output.mp4
```

Fade from full volume to 30%:

```bash
melt video.mp4 \
  -filter volume gain=1 end=0.3 in=100 out=200 \
  -consumer avformat:output.mp4
```

---

## Audio Ducking (Background Music)

Lower background music when voice appears:

```bash
melt video.mp4 \
  -filter volume gain=1 end=0.2 in=100 out=125 \
  -filter volume gain=0.2 end=1 in=300 out=325 \
  -consumer avformat:output.mp4
```

**Result:**
- Normal volume until frame 100
- Duck to 20% volume over frames 100-125 (voice section)
- Return to full volume over frames 300-325

---

## Tips

- **Natural fade length:** 2-3 seconds (50-75 frames at 25fps) sounds most natural
- **Quick cuts:** Use 1-second fades (25 frames) for fast-paced videos
- **Calculate frames:** Multiply desired seconds by your video's FPS
- **Avoid clipping:** Don't set `end` value above 1.5 to prevent distortion
- **Test with headphones:** Subtle fades are easier to hear with headphones
- **Audio-only edits:** Use `-an` with video and re-add faded audio separately for precision

---

## Troubleshooting

**Problem:** Fade is too abrupt or not smooth

**Solution:** Increase frame count for fade. Try 75-125 frames instead of 25-50

---

**Problem:** Audio distorts or clips during fade

**Solution:** Lower the `end` gain value. Use `end=0.8` instead of `end=1.5`

---

**Problem:** Fade starts at wrong time

**Solution:** Check `in=` and `out=` frame numbers. Verify FPS with: `ffprobe video.mp4`

---

**Problem:** Can't hear the fade effect

**Solution:**
1. Increase fade duration (more frames)
2. Check audio isn't already quiet
3. Test with headphones for subtle fades

---

## Quick Reference

| Task | Command |
|------|---------|
| Fade in (3s at 25fps) | `-filter volume gain=0 end=1 in=0 out=75` |
| Fade out (3s at 25fps) | `-filter volume gain=1 end=0 in=X out=Y` |
| Quick fade (1s) | `in=0 out=25` (adjust for FPS) |
| Long fade (5s) | `in=0 out=125` (adjust for FPS) |
| Fade to 50% | `gain=1 end=0.5` |
| Audio crossfade | `-mix 50 -mixer luma -mixer mix:-1` |

---

## Advanced Example: Complete Audio Treatment

```bash
# Fade in, duck for voice section, fade out
melt video.mp4 in=0 out=500 \
  -filter volume gain=0 end=1 in=0 out=50 \
  -filter volume gain=1 end=0.3 in=100 out=125 \
  -filter volume gain=0.3 end=1 in=375 out=400 \
  -filter volume gain=1 end=0 in=450 out=500 \
  -consumer avformat:output.mp4
```

**Result:**
1. Fade in (frames 0-50)
2. Duck to 30% (frames 100-125)
3. Return to full volume (frames 375-400)
4. Fade out (frames 450-500)

---

## Next Steps

- [Transitions →](03-transitions.md) - Combine audio fades with video transitions
- [Speed Control →](05-speed-control.md) - Speed changes affect audio pitch
- [See All Filters →](../reference/filters.md) - More audio processing options
- [Batch Processing →](../examples/batch-processing.md) - Automate audio fades

---

[← Back to Demos](README.md)
