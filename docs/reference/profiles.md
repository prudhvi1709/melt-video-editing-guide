# Video Profiles Reference

MLT profiles define video output properties like resolution, frame rate, and aspect ratio.

---

## Using Profiles

```bash
melt video.mp4 -profile hdv_720_25p -consumer avformat:output.mp4
```

---

## Common HDV Profiles

### 720p Profiles

**hdv_720_25p**
- Resolution: 1280x720
- Frame rate: 25 fps
- Progressive scan

**hdv_720_30p**
- Resolution: 1280x720
- Frame rate: 30 fps
- Progressive scan

**hdv_720_50p**
- Resolution: 1280x720
- Frame rate: 50 fps
- Progressive scan

**hdv_720_60p**
- Resolution: 1280x720
- Frame rate: 60 fps
- Progressive scan

---

### 1080p Profiles

**hdv_1080_25p**
- Resolution: 1920x1080
- Frame rate: 25 fps
- Progressive scan

**hdv_1080_30p**
- Resolution: 1920x1080
- Frame rate: 30 fps
- Progressive scan

**hdv_1080_50i**
- Resolution: 1920x1080
- Frame rate: 50 fields/sec
- Interlaced scan

**hdv_1080_60i**
- Resolution: 1920x1080
- Frame rate: 60 fields/sec
- Interlaced scan

---

## List Available Profiles

```bash
ls /usr/share/mlt/profiles/
# or
ls /usr/local/share/mlt-7/profiles/
```

---

## Custom Profile

Create custom profile file:

```ini
# my_profile
description=Custom 1080p 30fps
frame_rate_num=30
frame_rate_den=1
width=1920
height=1080
progressive=1
sample_aspect_num=1
sample_aspect_den=1
display_aspect_num=16
display_aspect_den=9
colorspace=709
```

Use custom profile:
```bash
melt video.mp4 -profile /path/to/my_profile
```

---

## Common Use Cases

**Web Video (720p):**
```bash
melt video.mp4 -profile hdv_720_30p
```

**Full HD (1080p):**
```bash
melt video.mp4 -profile hdv_1080_30p
```

**High Frame Rate:**
```bash
melt video.mp4 -profile hdv_720_60p
```

---

[← Back to Reference](../reference/)
