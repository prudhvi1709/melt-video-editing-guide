# MELT Troubleshooting Guide

Comprehensive solutions to common issues when using MELT for video editing.

---

## Installation Issues

### MELT Command Not Found

**Problem:** Terminal doesn't recognize `melt` command

**Solution:**
1. Check if MELT is installed:
   ```bash
   which melt
   ```
2. Verify PATH configuration:
   ```bash
   echo $PATH
   ```
3. Reinstall if needed:
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install melt

   # macOS
   brew install mlt

   # Fedora/RHEL
   sudo dnf install mlt mlt-freeworld
   ```

---

### Missing Codecs

**Problem:** Error: "Failed to create consumer" or "No consumer found"

**Solution:**
1. Install FFmpeg:
   ```bash
   # Ubuntu/Debian
   sudo apt install ffmpeg

   # macOS
   brew install ffmpeg

   # Fedora
   sudo dnf install ffmpeg
   ```
2. Install additional plugins:
   ```bash
   sudo apt install mlt-freeworld  # Fedora/RHEL
   ```
3. Check available codecs:
   ```bash
   melt -query video_codecs
   melt -query audio_codecs
   ```

---

### Library Errors

**Problem:** "error while loading shared libraries"

**Solution:**
1. Install dependencies:
   ```bash
   sudo apt install libmlt++3 libmlt-data
   ```
2. Update library cache:
   ```bash
   sudo ldconfig
   ```
3. Build from source if package issues persist (see main README)

---

## Video Quality Issues

### Blurry or Low-Quality Output

**Problem:** Output video looks blurry or lower quality than source

**Solution:**
1. Lower CRF value (better quality):
   ```bash
   # Instead of crf=28
   melt video.mp4 -consumer avformat:output.mp4 crf=20
   ```
2. Use slower preset for better compression:
   ```bash
   melt video.mp4 -consumer avformat:output.mp4 preset=slow crf=20
   ```
3. Match source resolution (avoid unnecessary scaling)
4. Use appropriate profile:
   ```bash
   melt video.mp4 -profile hdv_1080_30p -consumer avformat:output.mp4
   ```

---

### Color Banding

**Problem:** Visible color bands or posterization in gradients

**Solution:**
1. Use higher bit depth codec (if supported)
2. Lower CRF value (18-20 instead of 28)
3. Avoid extreme color grading adjustments
4. Export with higher bitrate:
   ```bash
   melt video.mp4 -consumer avformat:output.mp4 vb=8000k
   ```

---

### Audio Desync

**Problem:** Audio and video out of sync in output

**Solution:**
1. Check source file frame rate:
   ```bash
   ffprobe video.mp4
   ```
2. Use correct profile matching source FPS:
   ```bash
   melt video.mp4 -profile hdv_1080_30p -consumer avformat:output.mp4
   ```
3. Avoid mixing different frame rates without conversion
4. Re-encode audio:
   ```bash
   melt video.mp4 -consumer avformat:output.mp4 acodec=aac ab=192k
   ```

---

## Performance Issues

### Slow Rendering

**Problem:** Video processing takes very long

**Solution:**
1. Use faster encoding preset:
   ```bash
   melt video.mp4 -consumer avformat:output.mp4 preset=fast
   ```
2. Increase CRF for faster encoding (lower quality):
   ```bash
   melt video.mp4 -consumer avformat:output.mp4 crf=30 preset=veryfast
   ```
3. Use hardware acceleration (if available):
   ```bash
   # NVIDIA NVENC
   melt video.mp4 -consumer avformat:output.mp4 vcodec=h264_nvenc

   # Intel Quick Sync
   melt video.mp4 -consumer avformat:output.mp4 vcodec=h264_qsv

   # macOS VideoToolbox
   melt video.mp4 -consumer avformat:output.mp4 vcodec=h264_videotoolbox
   ```
4. Reduce output resolution
5. Process shorter segments and concatenate

---

### High Memory Usage

**Problem:** MELT consuming excessive RAM

**Solution:**
1. Close other applications
2. Process video in smaller segments
3. Reduce output resolution
4. Use simpler filters (avoid heavy effects)
5. Increase swap space (Linux):
   ```bash
   sudo fallocate -l 4G /swapfile
   sudo chmod 600 /swapfile
   sudo mkswap /swapfile
   sudo swapon /swapfile
   ```

---

### Process Crashes

**Problem:** MELT crashes or terminates unexpectedly

**Solution:**
1. Check input file integrity:
   ```bash
   ffmpeg -v error -i video.mp4 -f null -
   ```
2. Re-encode problematic source:
   ```bash
   ffmpeg -i problematic.mp4 -c:v libx264 -crf=20 -c:a aac fixed.mp4
   ```
3. Reduce complexity (fewer filters, shorter clips)
4. Update MELT to latest version
5. Check system resources (RAM, disk space)

---

## Command Errors

### Filter Not Found

**Problem:** "Failed to create filter" or "Unknown filter"

**Solution:**
1. List available filters:
   ```bash
   melt -query filters
   ```
2. Check filter name spelling (case-sensitive)
3. Install missing plugins:
   ```bash
   sudo apt install frei0r-plugins
   ```
4. Use alternative filter if unavailable

---

### Invalid Parameters

**Problem:** Command runs but produces unexpected results

**Solution:**
1. Check parameter syntax:
   ```bash
   melt -query filter:<filtername>
   ```
2. Verify frame numbers match video length:
   ```bash
   ffprobe -v error -select_streams v:0 \
     -count_packets -show_entries stream=nb_read_packets \
     -of csv=p=0 video.mp4
   ```
3. Use correct parameter format:
   - in=0 out=100 (no spaces around =)
   - Paths with spaces need quotes: `"path with spaces.mp4"`

---

### Output File Errors

**Problem:** "Permission denied" or "Cannot create file"

**Solution:**
1. Check write permissions:
   ```bash
   ls -l output_directory/
   ```
2. Ensure output directory exists:
   ```bash
   mkdir -p output_directory
   ```
3. Check available disk space:
   ```bash
   df -h
   ```
4. Use absolute paths instead of relative

---

## Trimming Issues

### Wrong Duration in Output

**Problem:** Trimmed video has incorrect length

**Solution:**
1. Verify frame rate:
   ```bash
   ffprobe video.mp4 | grep fps
   ```
2. Calculate frames correctly:
   - At 25fps: 1 second = 25 frames, 10 seconds = 250 frames
   - At 30fps: 1 second = 30 frames, 10 seconds = 300 frames
3. Use frame numbers, not timestamps
4. Test with small clip first:
   ```bash
   melt video.mp4 in=0 out=25 -consumer avformat:test.mp4
   ```

---

## Filter Issues

### Text Not Showing (Watermark)

**Problem:** Watermark text doesn't appear

**Solution:**
1. Ensure `+` prefix and `.txt` extension:
   ```bash
   # Correct
   melt video.mp4 -filter watermark:"+Your Text.txt"

   # Incorrect
   melt video.mp4 -filter watermark:"Your Text"
   ```
2. Check text color contrasts with video
3. Verify positioning parameters
4. Try image watermark instead as test

---

### Watermark Too Large/Small

**Problem:** Watermark doesn't fit properly

**Solution:**
1. Adjust geometry percentages:
   ```bash
   composite.geometry=10%,10%,20%,20%  # x,y,width,height
   ```
2. Resize image beforehand:
   ```bash
   convert logo.png -resize 200x100 logo-small.png
   ```
3. Use halign/valign for positioning:
   ```bash
   composite.halign=right composite.valign=bottom
   ```

---

## Transition Issues

### Jerky Transitions

**Problem:** Transitions appear choppy or stuttering

**Solution:**
1. Increase transition frame count:
   ```bash
   # Instead of -mix 15
   melt clip1.mp4 clip2.mp4 -mix 50 -mixer luma
   ```
2. Ensure clips have same frame rate
3. Use appropriate mixer type (luma is smoothest)
4. Check source video quality

---

### Audio Cuts Abruptly During Transition

**Problem:** Audio doesn't fade with video

**Solution:**
Add audio mixer:
```bash
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma -mixer mix:-1
```
The `-mixer mix:-1` creates audio crossfade.

---

### Transition Too Slow/Fast

**Problem:** Transition duration doesn't feel right

**Solution:**
Adjust frame count:
```bash
# Quick transition (0.5s at 25fps)
melt clip1.mp4 clip2.mp4 -mix 12 -mixer luma

# Standard transition (1s at 25fps)
melt clip1.mp4 clip2.mp4 -mix 25 -mixer luma

# Slow transition (2s at 25fps)
melt clip1.mp4 clip2.mp4 -mix 50 -mixer luma
```

---

## Speed Control Issues

### Audio Sounds Distorted

**Problem:** Audio has "chipmunk" or "slow-mo" effect

**Solution:**
1. Audio pitch changes with speed. Extract and re-add original audio:
   ```bash
   # Extract audio
   ffmpeg -i video.mp4 audio.mp3

   # Speed change video only (mute audio)
   melt video.mp4 -filter timewarp speed=0.5 -an \
     -consumer avformat:output-video.mp4

   # Recombine
   ffmpeg -i output-video.mp4 -i audio.mp3 -c copy output.mp4
   ```
2. Or mute audio entirely:
   ```bash
   melt video.mp4 -filter timewarp speed=0.5 -an \
     -consumer avformat:output.mp4
   ```

---

### Choppy Slow Motion

**Problem:** Slow motion playback looks stuttery

**Solution:**
1. Use higher frame rate source (60fps+)
2. Reduce slowdown amount (0.75x instead of 0.25x)
3. Consider interpolation (external tool)
4. Test with different speed values

---

## Audio Fade Issues

### Can't Hear Fade Effect

**Problem:** Audio fade isn't noticeable

**Solution:**
1. Increase fade duration (more frames):
   ```bash
   # Instead of 25 frames, use 75
   melt video.mp4 -filter volume gain=0 end=1 in=0 out=75
   ```
2. Test with headphones (subtle fades easier to hear)
3. Check source audio isn't already quiet
4. Verify correct in/out frame numbers

---

### Fade Starts at Wrong Time

**Problem:** Fade occurs at unexpected position

**Solution:**
1. Verify frame numbers:
   ```bash
   ffprobe video.mp4  # Check total frames
   ```
2. Calculate correctly:
   - FPS × seconds = frames
   - 25fps × 3 seconds = 75 frames
3. Test with short clip first

---

## Color Grading Issues

### Colors Look Unrealistic

**Problem:** Graded video has unnatural colors

**Solution:**
1. Use subtle adjustments (0.8-1.2 range):
   ```bash
   # Too extreme
   lift_r=1.5 lift_g=0.5 lift_b=2.0  # Bad

   # Subtle
   lift_r=1.1 lift_g=1.0 lift_b=0.9  # Good
   ```
2. Compare with reference images
3. Check on multiple displays
4. Start with smaller changes

---

### Blacks Crushed or Highlights Blown

**Problem:** Loss of detail in shadows or highlights

**Solution:**
1. Lift crushed blacks:
   ```bash
   lift_r=1.2 lift_g=1.2 lift_b=1.2  # Brighten shadows
   ```
2. Compress blown highlights:
   ```bash
   gain_r=0.8 gain_g=0.8 gain_b=0.8  # Darken highlights
   ```
3. Use brightness filter for overall adjustment first
4. Check with waveform scopes if available

---

## Batch Processing Issues

### Script Fails on Some Files

**Problem:** Batch script works for some videos but not others

**Solution:**
1. Add error checking:
   ```bash
   for file in *.mp4; do
     if [ -f "$file" ]; then
       melt "$file" -filter greyscale \
         -consumer avformat:"processed_${file}" || echo "Failed: $file"
     fi
   done
   ```
2. Check file format consistency
3. Re-encode problematic files first
4. Process in smaller batches

---

### Out of Disk Space

**Problem:** Batch processing fills up disk

**Solution:**
1. Check available space before starting:
   ```bash
   df -h
   ```
2. Process and delete incrementally:
   ```bash
   for file in *.mp4; do
     melt "$file" -filter greyscale -consumer avformat:"processed_${file}"
     # Verify output exists and is valid before deleting source
     if [ -s "processed_${file}" ]; then
       rm "$file"
     fi
   done
   ```
3. Use higher CRF for smaller files (crf=30)
4. Move to external storage

---

## General Debugging Tips

### Enable Verbose Mode

See detailed processing information:
```bash
melt -verbose video.mp4 -consumer avformat:output.mp4
```

---

### Test with Short Clips

Validate commands quickly:
```bash
# Extract first 5 seconds for testing
melt video.mp4 in=0 out=125 -consumer avformat:test.mp4
```

---

### Validate Input Files

Check file integrity:
```bash
# Quick check
ffmpeg -v error -i video.mp4 -f null -

# Detailed info
ffprobe -v error -show_format -show_streams video.mp4
```

---

### Check System Resources

Monitor during processing:
```bash
# CPU and memory
top

# Disk I/O
iotop

# Disk space
df -h
```

---

## Getting Help

### Query MELT Capabilities

```bash
# List all filters
melt -query filters

# List transitions
melt -query transitions

# List producers (input formats)
melt -query producers

# List consumers (output formats)
melt -query consumers

# Get filter details
melt -query filter:brightness
```

---

### Community Resources

- [MLT Framework Documentation](https://www.mltframework.org/docs/melt/)
- [MLT GitHub Issues](https://github.com/mltframework/mlt/issues)
- [Linux Magazine: Command-Line Melt](https://www.linux-magazine.com/Issues/2018/206/Command-Line-Melt)
- [Stack Overflow - MLT Tag](https://stackoverflow.com/questions/tagged/mlt)

---

### Reporting Bugs

If you find a bug in MELT:

1. Check if it's a known issue on [GitHub](https://github.com/mltframework/mlt/issues)
2. Create minimal reproduction case
3. Include:
   - MELT version: `melt --version`
   - OS and version
   - Complete command used
   - Error messages
   - Sample input file (if possible)

---

## Quick Troubleshooting Checklist

- [ ] MELT installed and in PATH?
- [ ] FFmpeg installed?
- [ ] Input file valid (test with `ffprobe`)?
- [ ] Correct parameter syntax (no spaces around `=`)?
- [ ] Frame numbers correct for video FPS?
- [ ] Sufficient disk space?
- [ ] Filter name spelled correctly?
- [ ] Output directory exists and writable?
- [ ] Tested with short clip first?
- [ ] Checked verbose output for errors?

---

[← Back to Guides](../README.md#guides)
