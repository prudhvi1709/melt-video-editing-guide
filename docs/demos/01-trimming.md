# Trimming & Cutting Videos with MELT

Learn how to extract specific segments from videos using MELT's powerful trimming capabilities.

---

## Demo Video

<video width="100%" controls>
  <source src="../../videos/demos/demo-trimming.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** The original video trimmed to first 250 frames (approximately 10 seconds at 25fps).

---

## Command Used

```bash
melt video.mp4 in=0 out=250 -consumer avformat:output.mp4 vcodec=libx264 crf=28
```

**Breakdown:**
- `video.mp4` - Source video file
- `in=0` - Start at frame 0 (beginning)
- `out=250` - End at frame 250
- `-consumer avformat:output.mp4` - Output as MP4 file
- `vcodec=libx264` - Use H.264 video codec
- `crf=28` - Quality level (lower = better quality, 18-28 recommended)

---

## Understanding Frame Numbers

MELT uses frame-based indexing. To convert time to frames:

**Formula:** `frames = seconds × fps`

**Examples at 25 fps:**
| Time | Frames |
|------|--------|
| 5 seconds | 125 frames |
| 10 seconds | 250 frames |
| 30 seconds | 750 frames |
| 1 minute | 1500 frames |

**Examples at 30 fps:**
| Time | Frames |
|------|--------|
| 5 seconds | 150 frames |
| 10 seconds | 300 frames |
| 30 seconds | 900 frames |
| 1 minute | 1800 frames |

---

## Variations

### Trim from Start
Extract the first 5 seconds (125 frames at 25fps):

```bash
melt video.mp4 out=125 -consumer avformat:output.mp4
```

### Trim to End
Extract everything after 10 seconds:

```bash
melt video.mp4 in=250 -consumer avformat:output.mp4
```

### Extract Middle Segment
Get 10 seconds starting from 5 seconds in:

```bash
melt video.mp4 in=125 out=375 -consumer avformat:output.mp4
```

---

## Multiple Segments

Extract and concatenate multiple segments from the same video:

```bash
melt video.mp4 in=0 out=100 \
     video.mp4 in=200 out=300 \
     video.mp4 in=500 out=600 \
     -consumer avformat:output.mp4
```

---

## Batch Trimming

Apply the same trim to multiple different videos:

```bash
melt -group in=0 out=100 clip1.mp4 clip2.mp4 clip3.mp4 \
     -consumer avformat:output.mp4
```

---

## Tips

- **Check FPS first:** Use `ffprobe video.mp4` to find the frame rate
- **Test with small clips:** Trim a small section first to verify frame numbers
- **Quality vs Size:** Lower CRF (18-23) for better quality, higher (28-32) for smaller files
- **Fast encoding:** Add `preset=fast` for quicker processing

---

## Troubleshooting

**Problem:** Wrong duration in output

**Solution:** Verify your frame calculations match the video's FPS

**Problem:** Output quality too low

**Solution:** Reduce CRF value (try `crf=23` or `crf=20`)

---

## Next Steps

- [Apply Filters →](02-filters.md) - Add effects to trimmed segments
- [Create Transitions →](03-transitions.md) - Blend trimmed clips together
- [Batch Processing →](../examples/batch-processing.md) - Automate trimming

---

[← Back to Demos](README.md)
