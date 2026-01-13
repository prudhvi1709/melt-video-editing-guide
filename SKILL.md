# MELT Command-Line Video Editing Guide

> **Master video editing from the command line using MLT Framework and MELT**

**A comprehensive guide to the most common and high-impact video editing techniques with concise command-line snippets.**

---

## Table of Contents

- [What is MELT?](#what-is-melt)
- [Installation](#installation)
- [Basic Syntax](#basic-syntax)
- [Video Editing Techniques](#video-editing-techniques)
  - [1. Trimming & Cutting](#1-trimming--cutting)
  - [2. Filters & Effects](#2-filters--effects)
  - [3. Transitions](#3-transitions)
  - [4. Watermarks & Overlays](#4-watermarks--overlays)
  - [5. Speed Control](#5-speed-control)
  - [6. Audio Fades](#6-audio-fades)
  - [7. Color Grading](#7-color-grading)
- [Quick Reference](#quick-reference)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

---

## What is MELT?

**MELT** is the command-line interface for the MLT (Media Lovin' Toolkit) multimedia framework. It enables professional video editing entirely from the terminal.

**Key Features:**

- ✂️ Trim and cut videos with frame-precision
- 🎨 Apply filters and visual effects
- 🔄 Create smooth transitions between clips
- 💧 Add watermarks and text overlays
- ⚡ Control playback speed (slow motion, fast forward)
- 🎵 Fade audio in and out
- 🌈 Professional color grading
- 🔁 Batch process multiple videos
- 📦 No GUI required - perfect for automation

**Used by:** Shotcut, Kdenlive, Flowblade video editors

---

## Installation

### Ubuntu/Debian

```bash
# Install MELT
sudo apt update
sudo apt install melt

# Verify installation
melt --version
```

### macOS

```bash
# Install using Homebrew
brew install mlt

# Verify installation
melt --version
```

### Fedora/RHEL

```bash
# Install MELT
sudo dnf install mlt mlt-freeworld

# Verify installation
melt --version
```

### Build from Source

```bash
# Clone repository
git clone https://github.com/mltframework/mlt.git
cd mlt

# Build with CMake
cmake -B build -S .
cmake --build build

# Install
sudo cmake --install build

# Or test without installation
source setenv
```

**Requirements:** FFmpeg, C11 compiler, pthread, CMake

---

## Basic Syntax

```bash
melt [input] [options] -consumer avformat:output.mp4
```

**Key Components:**

- `input` - Source video file(s)
- `options` - Filters, effects, parameters
- `-consumer` - Output format and file

**Example:**

```bash
melt video.mp4 -filter greyscale -consumer avformat:output.mp4
```

---

## Video Editing Techniques

### 1. Trimming & Cutting

Extract specific segments from videos with frame-precision.

**📹 Demo Video:** [demo-trimming.mp4](videos/demos/demo-trimming.mp4)

#### Basic Trim

```bash
# Extract frames 0-250 (10 seconds at 25fps)
melt video.mp4 in=0 out=250 -consumer avformat:output.mp4
```

**Parameters:**

- `in=N` - Start frame
- `out=N` - End frame
- Frame calculation: `seconds × fps = frames`

#### Trim from Start

```bash
# Extract first 5 seconds (125 frames at 25fps)
melt video.mp4 out=125 -consumer avformat:output.mp4
```

#### Trim to End

```bash
# Extract everything after 10 seconds
melt video.mp4 in=250 -consumer avformat:output.mp4
```

#### Extract Middle Segment

```bash
# Get 10 seconds starting from 5 seconds in
melt video.mp4 in=125 out=375 -consumer avformat:output.mp4
```

#### Multiple Segments

```bash
# Extract and concatenate multiple segments
melt video.mp4 in=0 out=100 \
     video.mp4 in=200 out=300 \
     video.mp4 in=500 out=600 \
     -consumer avformat:output.mp4
```

#### Frame Rate Reference

**At 25 fps:**
| Time | Frames |
|------|--------|
| 1 second | 25 |
| 5 seconds | 125 |
| 10 seconds | 250 |
| 1 minute | 1500 |

**At 30 fps:**
| Time | Frames |
|------|--------|
| 1 second | 30 |
| 5 seconds | 150 |
| 10 seconds | 300 |
| 1 minute | 1800 |

#### Tips

- Check FPS first: `ffprobe video.mp4`
- Test with small clips before processing entire video
- Use `in=0 out=25` for 1-second test clips

#### Troubleshooting

- **Wrong duration?** Verify frame calculations match video FPS
- **Quality loss?** Lower CRF: `crf=20` instead of default

[📖 Detailed Guide](demos/01-trimming.md)

---

### 2. Filters & Effects

Apply visual effects and filters to transform your videos.

**📹 Demo Videos:**

- [demo-filter-grayscale.mp4](videos/demos/demo-filter-grayscale.mp4)
- [demo-brightness.mp4](videos/demos/demo-brightness.mp4)

#### Grayscale (Black & White)

```bash
melt video.mp4 -filter greyscale -consumer avformat:output.mp4
```

#### Brightness Adjustment

```bash
# Increase brightness by 50%
melt video.mp4 -filter brightness level=1.5 -consumer avformat:output.mp4
```

**Brightness levels:**

- `0.5` = 50% brightness (darker)
- `1.0` = Normal (no change)
- `1.5` = 150% brightness (brighter)
- `2.0` = 200% brightness (very bright)

#### Sepia Tone

```bash
melt video.mp4 -filter sepia -consumer avformat:output.mp4
```

#### Blur Effect

```bash
melt video.mp4 -filter boxblur hori=5 vert=5 -consumer avformat:output.mp4
```

#### Vignette

```bash
melt video.mp4 -filter vignette -consumer avformat:output.mp4
```

#### Multiple Filters (Chain)

```bash
# Apply multiple filters in sequence
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.2 \
  -filter vignette \
  -consumer avformat:output.mp4
```

#### Filter to Specific Segment

```bash
# Apply brightness only to frames 0-50
melt video.mp4 -filter brightness in=0 out=50 level=1.5 \
  -consumer avformat:output.mp4
```

#### Common Filter Combinations

**Vintage Look:**

```bash
melt video.mp4 \
  -filter sepia \
  -filter vignette \
  -filter oldfilm \
  -consumer avformat:output.mp4
```

**High Contrast B&W:**

```bash
melt video.mp4 \
  -filter greyscale \
  -filter brightness level=1.3 \
  -consumer avformat:output.mp4
```

**Soft Bright:**

```bash
melt video.mp4 \
  -filter brightness level=1.2 \
  -filter boxblur hori=2 vert=2 \
  -consumer avformat:output.mp4
```

#### Query Available Filters

```bash
# List all filters
melt -query filters

# Get filter details
melt -query filter:brightness
```

#### Tips

- Test filters on short clips first (5-10 seconds)
- Order matters - filters apply sequentially
- More filters = slower processing
- Use `-filter brightness in=X out=Y` to limit range

#### Troubleshooting

- **Filter not found?** Check spelling: `melt -query filters`
- **Video too dark/bright?** Adjust `level` parameter in small increments (0.1)
- **Processing slow?** Reduce number of filters or use simpler ones

[📖 Detailed Guide](demos/02-filters.md)

---

### 3. Transitions

Create smooth transitions between video clips.

**📹 Demo Video:** [demo-transitions.mp4](videos/demos/demo-transitions.mp4)

#### Basic Dissolve Transition

```bash
# 25-frame dissolve between two clips
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma \
  -consumer avformat:output.mp4
```

**Transition duration:**

- At 25fps: 25 frames = 1 second
- At 30fps: 30 frames = 1 second

#### Transition with Audio Crossfade

```bash
# Video + audio transition
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma -mixer mix:-1 \
  -consumer avformat:output.mp4
```

The `-mixer mix:-1` creates audio crossfade.

#### Multiple Clips with Transitions

```bash
# Four clips with transitions between each
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma \
     clip3.mp4 -mix 25 -mixer luma \
     clip4.mp4 -mix 25 -mixer luma \
     -consumer avformat:output.mp4
```

#### Variable Transition Lengths

```bash
# Different transition durations
melt clip1.mp4 clip2.mp4 -mix 50 -mixer luma \
     clip3.mp4 -mix 15 -mixer luma \
     -consumer avformat:output.mp4
```

#### Fade to Black

```bash
melt clip1.mp4 colour:black out=25 -mix 25 -mixer luma \
  -consumer avformat:output.mp4
```

#### Fade from Black

```bash
melt colour:black out=25 clip1.mp4 -mix 25 -mixer luma \
  -consumer avformat:output.mp4
```

#### Slideshow with Transitions

```bash
# Image slideshow with dissolve transitions
melt img1.jpg out=100 \
     img2.jpg out=100 -mix 25 -mixer luma \
     img3.jpg out=100 -mix 25 -mixer luma \
     -consumer avformat:slideshow.mp4
```

#### Transition Duration Table

| Frames (25fps) | Duration | Use Case            |
| -------------- | -------- | ------------------- |
| 12-15          | 0.5s     | Quick transition    |
| 25-30          | 1s       | Standard transition |
| 50-75          | 2-3s     | Slow, smooth fade   |

#### Tips

- Match timing - ensure transitions feel natural
- Use same transition length throughout for consistency
- Add `-mixer mix:-1` for audio crossfade
- Test with 25 frames (1 second) as starting point

#### Troubleshooting

- **Jerky transitions?** Increase frame count (try 50 instead of 25)
- **Audio cuts abruptly?** Add `-mixer mix:-1` for audio crossfade
- **Transition too slow?** Reduce frame count (try 12-15 frames)

[📖 Detailed Guide](demos/03-transitions.md)

---

### 4. Watermarks & Overlays

Add text watermarks, logos, and overlays to videos.

**📹 Demo Video:** [demo-watermarks.mp4](videos/demos/demo-watermarks.mp4)

#### Text Watermark

```bash
# Add text watermark at bottom center
melt video.mp4 \
  -filter watermark:"+Your Text Here.txt" \
    composite.halign=center \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

**Important:** Text requires `+` prefix and `.txt` extension!

#### Image Watermark (Logo)

```bash
# Add logo watermark
melt video.mp4 -filter watermark:logo.png \
  -consumer avformat:output.mp4
```

#### Position Watermark

**Bottom Right:**

```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=right \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

**Center:**

```bash
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=center \
    composite.valign=middle \
  -consumer avformat:output.mp4
```

**Custom Position (Percentage):**

```bash
# Position at x=10%, y=10%, width=20%, height=20%
melt video.mp4 \
  -filter watermark:logo.png \
    composite.geometry=10%,10%,20%,20% \
  -consumer avformat:output.mp4
```

#### Multi-line Text

```bash
# Use tilde (~) for line breaks
melt video.mp4 \
  -filter watermark:"+Line 1~Line 2~Line 3.txt" \
    composite.halign=center \
    composite.valign=bottom \
  -consumer avformat:output.mp4
```

#### Picture-in-Picture (PiP)

```bash
# Small video in bottom-right corner
melt main_video.mp4 \
  -filter watermark:overlay_video.mp4 \
    composite.geometry=70%,70%,25%,25% \
    composite.progressive=1 \
  -consumer avformat:output.mp4
```

#### Timed Watermark

```bash
# Show watermark only for frames 0-100
melt video.mp4 \
  -filter watermark:logo.png in=0 out=100 \
  -consumer avformat:output.mp4
```

#### Multiple Watermarks

```bash
# Add logo and copyright text
melt video.mp4 \
  -filter watermark:logo.png \
    composite.halign=left composite.valign=top \
  -filter watermark:"+© 2026 Your Name.txt" \
    composite.halign=right composite.valign=bottom \
  -consumer avformat:output.mp4
```

#### Alignment Options

**Horizontal (`halign`):** `left`, `center`, `right`
**Vertical (`valign`):** `top`, `middle`, `bottom`

#### Tips

- Use PNG with transparency for best logo results
- Keep watermarks under 20% of screen size
- Ensure text contrasts with video background
- Test positioning to avoid covering important content

#### Troubleshooting

- **Text not showing?** Ensure `+` prefix and `.txt` extension
- **Watermark too large?** Adjust `geometry` percentages
- **Text hard to read?** Add background or use contrasting colors

[📖 Detailed Guide](demos/04-watermarks.md)

---

### 5. Speed Control

Create slow motion, fast forward, and reverse effects.

**📹 Demo Video:** [demo-speed-control.mp4](videos/demos/demo-speed-control.mp4)

#### Slow Motion (0.5x Speed)

```bash
# Half speed - doubles duration
melt video.mp4 -filter timewarp speed=0.5 \
  -consumer avformat:output.mp4
```

#### Fast Forward (2x Speed)

```bash
# Double speed - halves duration
melt video.mp4 -filter timewarp speed=2.0 \
  -consumer avformat:output.mp4
```

#### Ultra Slow Motion (0.25x Speed)

```bash
# Quarter speed - quadruples duration
melt video.mp4 -filter timewarp speed=0.25 \
  -consumer avformat:output.mp4
```

#### Reverse Playback

```bash
melt video.mp4 -filter reverse \
  -consumer avformat:output.mp4
```

#### Reverse + Slow Motion

```bash
# Combine effects
melt video.mp4 -filter reverse -filter timewarp speed=0.5 \
  -consumer avformat:output.mp4
```

#### Variable Speed (Specific Segment)

```bash
# Normal → slow motion → normal
melt video.mp4 in=0 out=100 \
     video.mp4 in=100 out=200 -filter timewarp speed=0.5 \
     video.mp4 in=200 out=300 \
     -consumer avformat:output.mp4
```

#### Speed Values Table

| Speed | Effect        | Duration  | Use Case             |
| ----- | ------------- | --------- | -------------------- |
| 0.25  | Quarter speed | 4× longer | Ultra slow motion    |
| 0.5   | Half speed    | 2× longer | Dramatic slow motion |
| 1.0   | Normal speed  | Same      | No change            |
| 2.0   | Double speed  | Half      | Fast forward         |
| 4.0   | Quad speed    | Quarter   | Time-lapse effect    |

#### Audio Considerations

Speed changes affect audio pitch. To preserve original audio:

```bash
# Extract audio first
ffmpeg -i video.mp4 audio.mp3

# Speed change video only (mute audio)
melt video.mp4 -filter timewarp speed=0.5 -an \
  -consumer avformat:output-video.mp4

# Recombine with original audio
ffmpeg -i output-video.mp4 -i audio.mp3 -c:v copy \
  -c:a aac -shortest output-final.mp4
```

Or simply mute audio:

```bash
melt video.mp4 -filter timewarp speed=0.5 -an \
  -consumer avformat:output-silent.mp4
```

#### Tips

- Higher frame rate source (60fps+) produces smoother slow motion
- Test with 5-second clips before processing entire video
- Avoid extreme speeds (< 0.1 or > 10) for stability
- Audio becomes unusable at very slow/fast speeds
- Slow motion increases file size proportionally

#### Troubleshooting

- **Audio distorted?** Extract and re-add original audio or mute with `-an`
- **Choppy slow motion?** Source FPS too low; use 60fps source or reduce slowdown
- **Large output file?** Increase CRF: `crf=30` for smaller files
- **Corrupted output?** Avoid extreme speed values; stay within 0.25-4.0 range

[📖 Detailed Guide](demos/05-speed-control.md)

---

### 6. Audio Fades

Create smooth audio fade in and fade out effects.

**📹 Demo Video:** [demo-audio-fades.mp4](videos/demos/demo-audio-fades.mp4)

#### Fade In Only

```bash
# Fade from silence to full volume over 3 seconds (75 frames at 25fps)
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=75 \
  -consumer avformat:output.mp4
```

#### Fade Out Only

```bash
# Fade from full volume to silence over 3 seconds
melt video.mp4 \
  -filter volume gain=1 end=0 in=175 out=250 \
  -consumer avformat:output.mp4
```

#### Fade In and Fade Out (Complete)

```bash
# 3-second fade in, full volume middle, 3-second fade out
melt video.mp4 in=0 out=250 \
  -filter volume gain=0 end=1 in=0 out=75 \
  -filter volume gain=1 end=0 in=175 out=250 \
  -consumer avformat:output.mp4
```

**Parameters:**

- `gain=0` - Silent (0% volume)
- `gain=1` - Full volume (100%)
- `end=1` - Target volume at end of fade
- `in=0 out=75` - Frame range for fade

#### Quick Fade (1 Second)

```bash
# 1-second fade in at 25fps
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=25 \
  -consumer avformat:output.mp4
```

#### Long Fade (5 Seconds)

```bash
# 5-second fade in at 25fps
melt video.mp4 \
  -filter volume gain=0 end=1 in=0 out=125 \
  -consumer avformat:output.mp4
```

#### Audio Crossfade Between Clips

```bash
# Fade out first clip, fade in second clip
melt clip1.mp4 -filter volume gain=1 end=0 in=200 out=250 \
     clip2.mp4 -filter volume gain=0 end=1 in=0 out=50 \
     -consumer avformat:output.mp4
```

Or use automatic crossfade:

```bash
melt clip1.mp4 clip2.mp4 \
  -mix 50 -mixer luma -mixer mix:-1 \
  -consumer avformat:output.mp4
```

#### Fade to Specific Level

```bash
# Fade from silence to 50% volume
melt video.mp4 \
  -filter volume gain=0 end=0.5 in=0 out=75 \
  -consumer avformat:output.mp4
```

#### Audio Ducking (Background Music)

```bash
# Lower background music when voice appears
melt video.mp4 \
  -filter volume gain=1 end=0.2 in=100 out=125 \
  -filter volume gain=0.2 end=1 in=300 out=325 \
  -consumer avformat:output.mp4
```

#### Fade Duration Table

**At 25 fps:**
| Frames | Duration | Use Case |
|--------|----------|----------|
| 25 | 1 second | Quick fade |
| 50 | 2 seconds | Standard fade |
| 75 | 3 seconds | Smooth fade |
| 125 | 5 seconds | Long, gradual fade |

**At 30 fps:**
| Frames | Duration | Use Case |
|--------|----------|----------|
| 30 | 1 second | Quick fade |
| 60 | 2 seconds | Standard fade |
| 90 | 3 seconds | Smooth fade |
| 150 | 5 seconds | Long, gradual fade |

#### Tips

- 2-3 seconds (50-75 frames) sounds most natural
- Use 1-second fades (25 frames) for fast-paced videos
- Calculate frames: `desired_seconds × video_fps`
- Don't set `end` above 1.5 to prevent distortion
- Test with headphones for subtle fades

#### Troubleshooting

- **Fade too abrupt?** Increase frame count (try 75-125 instead of 25-50)
- **Audio distorts?** Lower `end` gain value (use 0.8 instead of 1.5)
- **Fade starts wrong time?** Check frame numbers; verify FPS with `ffprobe`
- **Can't hear fade?** Increase duration, check audio isn't already quiet, use headphones

[📖 Detailed Guide](demos/06-audio-fades.md)

---

### 7. Color Grading

Professional color grading using lift-gamma-gain controls.

**📹 Demo Video:** [demo-color-grading.mp4](videos/demos/demo-color-grading.mp4)

#### Warm Cinematic Look

```bash
# Teal shadows, orange highlights (Hollywood style)
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.05 lift_g=1.0 lift_b=0.95 \
    gamma_r=1.0 gamma_g=0.98 gamma_b=0.95 \
    gain_r=1.1 gain_g=1.05 gain_b=0.9 \
  -consumer avformat:output.mp4
```

#### Cool Blue Tone

```bash
# Modern, clinical look
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.95 lift_g=0.98 lift_b=1.05 \
    gamma_r=0.98 gamma_g=1.0 gamma_b=1.02 \
    gain_r=0.9 gain_g=0.95 gain_b=1.1 \
  -consumer avformat:output.mp4
```

#### High Contrast Look

```bash
# Dramatic shadows and highlights
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.8 lift_g=0.8 lift_b=0.8 \
    gamma_r=1.0 gamma_g=1.0 gamma_b=1.0 \
    gain_r=1.2 gain_g=1.2 gain_b=1.2 \
  -consumer avformat:output.mp4
```

#### Film-Style Grade

```bash
# Slightly faded, vintage feel
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.1 lift_g=1.1 lift_b=1.1 \
    gamma_r=1.05 gamma_g=1.05 gamma_b=1.05 \
    gain_r=0.95 gain_g=0.95 gain_b=0.95 \
  -consumer avformat:output.mp4
```

#### Natural Enhancement

```bash
# Subtle improvements without obvious grading
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.02 lift_g=1.02 lift_b=1.02 \
    gamma_r=1.05 gamma_g=1.05 gamma_b=1.05 \
    gain_r=1.0 gain_g=1.0 gain_b=1.0 \
  -consumer avformat:output.mp4
```

#### Understanding Lift-Gamma-Gain

**Three-Way Color Correction:**

| Control   | Affects                      | Range    | Use Case                                        |
| --------- | ---------------------------- | -------- | ----------------------------------------------- |
| **Lift**  | Shadows (dark areas)         | 0.0-2.0+ | Brighten/darken blacks, add color to shadows    |
| **Gamma** | Midtones (middle brightness) | 0.0-2.0+ | Adjust overall brightness, contrast             |
| **Gain**  | Highlights (bright areas)    | 0.0-2.0+ | Brighten/darken whites, add color to highlights |

**Parameter Values:**

- `1.0` = No change (neutral)
- `< 1.0` = Darken/reduce that color channel
- `> 1.0` = Brighten/increase that color channel
- `0.8-1.2` = Subtle adjustments
- `0.5-1.5` = Noticeable changes

#### Adjust Individual Tones

**Brighten Shadows Only:**

```bash
melt video.mp4 \
  -filter lift_gamma_gain lift_r=1.2 lift_g=1.2 lift_b=1.2 \
  -consumer avformat:output.mp4
```

**Adjust Midtones Only:**

```bash
melt video.mp4 \
  -filter lift_gamma_gain gamma_r=1.15 gamma_g=1.15 gamma_b=1.15 \
  -consumer avformat:output.mp4
```

**Control Highlights Only:**

```bash
melt video.mp4 \
  -filter lift_gamma_gain gain_r=0.9 gain_g=0.9 gain_b=0.9 \
  -consumer avformat:output.mp4
```

#### Color Tinting

**Orange Tint (Warm Sunset):**

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.1 lift_g=1.0 lift_b=0.9 \
    gamma_r=1.1 gamma_g=1.0 gamma_b=0.95 \
    gain_r=1.15 gain_g=1.05 gain_b=0.85 \
  -consumer avformat:output.mp4
```

**Blue/Cyan Tint (Night Scene):**

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=0.85 lift_g=0.95 lift_b=1.1 \
    gamma_r=0.9 gamma_g=0.95 gamma_b=1.05 \
    gain_r=0.9 gain_g=0.95 gain_b=1.1 \
  -consumer avformat:output.mp4
```

#### Combine with Brightness

```bash
melt video.mp4 \
  -filter lift_gamma_gain \
    lift_r=1.05 gain_b=0.9 \
  -filter brightness level=1.1 \
  -consumer avformat:output.mp4
```

#### Quick Reference Table

| Look            | Lift     | Gamma    | Gain     |
| --------------- | -------- | -------- | -------- |
| Warm/Orange     | R↑ B↓    | R↑ B↓    | R↑ G↑ B↓ |
| Cool/Blue       | R↓ B↑    | R↓ B↑    | R↓ B↑    |
| High Contrast   | All ↓    | Neutral  | All ↑    |
| Faded/Film      | All ↑    | Slight ↑ | All ↓    |
| Natural Enhance | Slight ↑ | Slight ↑ | Neutral  |

**Legend:** ↑ = increase (>1.0), ↓ = decrease (<1.0), R=red, G=green, B=blue

#### Tips

- Start subtle: small adjustments (1.0 ± 0.1) and gradually increase
- Work in order: adjust lift → gamma → gain sequentially
- Test on different displays
- Avoid clipping: stay within 0.5-1.5 range per channel
- Save successful grades for reuse

#### Troubleshooting

- **Colors unrealistic?** Reduce adjustments; stay within 0.8-1.2 range
- **Blacks crushed?** Increase `lift_r/g/b` above 1.0 to lift shadows
- **Highlights blown out?** Decrease `gain_r/g/b` below 1.0
- **Skin tones wrong?** Be careful with red/orange; keep `*_r` close to 1.0
- **Uneven color cast?** Adjust individual RGB channels

[📖 Detailed Guide](demos/07-color-grading.md)

---

## Quick Reference

### Essential Commands

| Operation          | Command                                                                                       |
| ------------------ | --------------------------------------------------------------------------------------------- |
| **Trim video**     | `melt video.mp4 in=50 out=100 -consumer avformat:output.mp4`                                  |
| **Grayscale**      | `melt video.mp4 -filter greyscale -consumer avformat:output.mp4`                              |
| **Brightness**     | `melt video.mp4 -filter brightness level=1.5 -consumer avformat:output.mp4`                   |
| **Concatenate**    | `melt clip1.mp4 clip2.mp4 -consumer avformat:output.mp4`                                      |
| **Transition**     | `melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma -consumer avformat:output.mp4`                  |
| **Text watermark** | `melt video.mp4 -filter watermark:"+Text.txt" -consumer avformat:output.mp4`                  |
| **Slow motion**    | `melt video.mp4 -filter timewarp speed=0.5 -consumer avformat:output.mp4`                     |
| **Audio fade in**  | `melt video.mp4 -filter volume gain=0 end=1 in=0 out=75 -consumer avformat:output.mp4`        |
| **Color grade**    | `melt video.mp4 -filter lift_gamma_gain lift_r=1.05 gain_b=0.9 -consumer avformat:output.mp4` |

### Common Parameters

| Parameter      | Description       | Example             |
| -------------- | ----------------- | ------------------- |
| `in=N`         | Start frame       | `in=0`              |
| `out=N`        | End frame         | `out=250`           |
| `-filter NAME` | Apply filter      | `-filter greyscale` |
| `-mix N`       | Transition frames | `-mix 25`           |
| `-mixer TYPE`  | Transition type   | `-mixer luma`       |
| `crf=N`        | Quality (18-28)   | `crf=23`            |
| `preset=TYPE`  | Encoding speed    | `preset=medium`     |
| `vcodec=CODEC` | Video codec       | `vcodec=libx264`    |
| `acodec=CODEC` | Audio codec       | `acodec=aac`        |

### Query Commands

```bash
# List all filters
melt -query filters

# List all transitions
melt -query transitions

# List video codecs
melt -query video_codecs

# List audio codecs
melt -query audio_codecs

# Get filter details
melt -query filter:brightness
```

### Batch Processing Template

```bash
#!/bin/bash
# Process all MP4 files in directory

for file in *.mp4; do
  output="processed_${file}"

  melt "$file" \
    -filter greyscale \
    -consumer avformat:"$output" \
      vcodec=libx264 crf=23

  echo "Created: $output"
done
```

---

## Troubleshooting

### Installation Issues

**Problem:** `melt: command not found`

**Solution:**

```bash
# Check if installed
which melt

# Reinstall
sudo apt install melt  # Ubuntu/Debian
brew install mlt       # macOS
```

---

**Problem:** "Failed to create consumer" or codec errors

**Solution:**

```bash
# Install FFmpeg
sudo apt install ffmpeg

# Check available codecs
melt -query video_codecs
```

---

### Video Quality Issues

**Problem:** Blurry or low-quality output

**Solution:**

```bash
# Lower CRF for better quality (18-20)
melt video.mp4 -consumer avformat:output.mp4 crf=20 preset=slow
```

---

**Problem:** Audio out of sync

**Solution:**

```bash
# Use correct profile matching source FPS
melt video.mp4 -profile hdv_1080_30p -consumer avformat:output.mp4
```

---

### Performance Issues

**Problem:** Very slow processing

**Solution:**

```bash
# Use faster preset and higher CRF
melt video.mp4 -consumer avformat:output.mp4 crf=28 preset=fast

# Or use hardware acceleration
melt video.mp4 -consumer avformat:output.mp4 vcodec=h264_nvenc  # NVIDIA
```

---

### Command Errors

**Problem:** Filter not found

**Solution:**

```bash
# List available filters
melt -query filters

# Check spelling (case-sensitive)
```

---

**Problem:** Wrong duration in trimmed output

**Solution:**

```bash
# Verify frame rate
ffprobe video.mp4 | grep fps

# Calculate frames: seconds × fps
# At 25fps: 10 seconds = 250 frames
# At 30fps: 10 seconds = 300 frames
```

---

**Problem:** Text watermark not showing

**Solution:**

```bash
# Ensure + prefix and .txt extension
melt video.mp4 -filter watermark:"+Your Text.txt"  # Correct
melt video.mp4 -filter watermark:"Your Text"       # Wrong
```

---

### Common Checks

```bash
# Validate input file
ffmpeg -v error -i video.mp4 -f null -

# Check file info
ffprobe video.mp4

# Test with short clip
melt video.mp4 in=0 out=25 -consumer avformat:test.mp4

# Enable verbose output
melt -verbose video.mp4 -consumer avformat:output.mp4
```

---

## Resources

### Official Documentation

- [MLT Framework Website](https://www.mltframework.org/)
- [MELT Documentation](https://www.mltframework.org/docs/melt/)
- [MLT GitHub Repository](https://github.com/mltframework/mlt)
- [MLT Plugins & Filters](https://www.mltframework.org/plugins/PluginsFilters/)

### Community Resources

- [Linux Magazine: Command-Line MELT](https://www.linux-magazine.com/Issues/2018/206/Command-Line-Melt)
- [MELT Man Page](https://linuxcommandlibrary.com/man/melt)
- [Stack Overflow - MLT Tag](https://stackoverflow.com/questions/tagged/mlt)

### Related Projects

- [Shotcut](https://www.shotcut.org/) - Free video editor built on MLT
- [Kdenlive](https://kdenlive.org/) - Professional video editor using MLT
- [Flowblade](https://jliljebl.github.io/flowblade/) - Multitrack video editor

### Deep Dive Guides

For detailed explanations, variations, and advanced techniques:

- [📖 Trimming & Cutting - Detailed Guide](demos/01-trimming.md)
- [📖 Filters & Effects - Detailed Guide](demos/02-filters.md)
- [📖 Transitions - Detailed Guide](demos/03-transitions.md)
- [📖 Watermarks & Overlays - Detailed Guide](demos/04-watermarks.md)
- [📖 Speed Control - Detailed Guide](demos/05-speed-control.md)
- [📖 Audio Fades - Detailed Guide](demos/06-audio-fades.md)
- [📖 Color Grading - Detailed Guide](demos/07-color-grading.md)
- [📖 Complete Troubleshooting Guide](guides/troubleshooting.md)

---

## Contributing

Found an error or want to add more techniques? Contributions welcome!

1. Fork the repository
2. Add your improvements
3. Submit a pull request

---

## License

This documentation is provided under the MIT License.
MLT Framework is licensed under LGPL.

**MLT Framework** - Copyright © 2008-2026 by Meltytech, LLC and contributors

---

**Last Updated:** 2026-01-13
**Version:** 1.0.0

🎬 **Happy command-line video editing with MELT!**
