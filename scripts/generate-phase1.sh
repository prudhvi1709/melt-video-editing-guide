#!/bin/bash
set -e

DEMOS_DIR="videos/demos"
SOURCE_VIDEO="$DEMOS_DIR/demo-trimming.mp4"
CRF=28
PRESET="medium"

echo "=== Phase 1: Generating Demo Videos ==="
echo

# 1. Transitions
echo "[1/5] Creating transitions demo..."
melt "$SOURCE_VIDEO" in=0 out=125 \
     "$DEMOS_DIR/demo-filter-grayscale.mp4" in=0 out=125 \
     -mix 25 -mixer luma \
     -consumer avformat:"$DEMOS_DIR/demo-transitions.mp4" \
       vcodec=libx264 crf=$CRF preset=$PRESET

echo "✓ Created demo-transitions.mp4"
echo

# 2. Watermarks
echo "[2/5] Creating watermarks demo..."
melt "$SOURCE_VIDEO" in=0 out=250 \
     -filter watermark:"+Sample Watermark.txt" \
       composite.halign=center composite.valign=bottom \
     -consumer avformat:"$DEMOS_DIR/demo-watermarks.mp4" \
       vcodec=libx264 crf=$CRF preset=$PRESET

echo "✓ Created demo-watermarks.mp4"
echo

# 3. Speed Control
echo "[3/5] Creating speed control demo..."
melt "$SOURCE_VIDEO" in=0 out=100 \
     -filter timewarp speed=0.5 \
     -consumer avformat:"$DEMOS_DIR/demo-speed-control.mp4" \
       vcodec=libx264 crf=$CRF preset=$PRESET

echo "✓ Created demo-speed-control.mp4"
echo

# 4. Audio Fades
echo "[4/5] Creating audio fades demo..."
melt "$SOURCE_VIDEO" in=0 out=250 \
     -filter volume gain=0 end=1 in=0 out=75 \
     -filter volume gain=1 end=0 in=175 out=250 \
     -consumer avformat:"$DEMOS_DIR/demo-audio-fades.mp4" \
       vcodec=libx264 crf=$CRF acodec=aac preset=$PRESET

echo "✓ Created demo-audio-fades.mp4"
echo

# 5. Color Grading
echo "[5/5] Creating color grading demo..."
melt "$SOURCE_VIDEO" in=0 out=250 \
     -filter lift_gamma_gain \
       lift_r=1.05 lift_g=1.0 lift_b=0.95 \
       gamma_r=1.0 gamma_g=0.98 gamma_b=0.95 \
       gain_r=1.1 gain_g=1.05 gain_b=0.9 \
     -consumer avformat:"$DEMOS_DIR/demo-color-grading.mp4" \
       vcodec=libx264 crf=$CRF preset=$PRESET

echo "✓ Created demo-color-grading.mp4"
echo

echo "=== Phase 1 Video Generation Complete! ==="
echo
echo "Generated videos:"
ls -lh "$DEMOS_DIR"/demo-*.mp4
