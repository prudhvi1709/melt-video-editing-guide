# Create Slideshow with MELT

Turn images into video slideshow with transitions.

---

## Basic Slideshow

```bash
melt img1.jpg out=100 \
     img2.jpg out=100 \
     img3.jpg out=100 \
     -consumer avformat:slideshow.mp4
```

**Result:** 3 images, each shown for 100 frames (4 seconds at 25fps).

---

## Slideshow with Transitions

```bash
melt img1.jpg out=100 \
     img2.jpg out=100 -mix 25 -mixer luma \
     img3.jpg out=100 -mix 25 -mixer luma \
     -consumer avformat:slideshow.mp4
```

**Result:** Smooth dissolve transitions between images.

---

## All Images in Folder

```bash
melt img_*.jpg out=100 -mix 25 -mixer luma \
  -consumer avformat:slideshow.mp4
```

---

## Add Background Music

```bash
melt img*.jpg out=150 -mix 25 -mixer luma \
     -track music.mp3 \
     -consumer avformat:slideshow.mp4
```

---

## Custom Duration per Image

```bash
melt img1.jpg out=150 \
     img2.jpg out=100 -mix 25 -mixer luma \
     img3.jpg out=200 -mix 25 -mixer luma \
     -consumer avformat:slideshow.mp4
```

---

## With Watermark

```bash
melt img*.jpg out=100 -mix 25 -mixer luma \
     -filter watermark:"+My Slideshow.txt" \
       composite.halign=center \
       composite.valign=bottom \
     -consumer avformat:slideshow.mp4
```

---

## High Quality Output

```bash
melt img*.jpg out=100 -mix 25 -mixer luma \
     -profile hdv_1080_30p \
     -consumer avformat:slideshow.mp4 \
       vcodec=libx264 crf=18 preset=slow
```

---

[← Back to Examples](../examples/)
