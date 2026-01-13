#!/bin/bash

ERRORS=0

echo "=== MELT Documentation Verification ==="
echo

# Check demo pages
echo "Checking demo pages..."
EXPECTED_DEMOS=(
  "01-trimming"
  "02-filters"
  "03-transitions"
  "04-watermarks"
  "05-speed-control"
  "06-audio-fades"
  "07-color-grading"
)

for demo in "${EXPECTED_DEMOS[@]}"; do
  if [ -f "docs/demos/${demo}.md" ]; then
    echo "  ✓ docs/demos/${demo}.md"
  else
    echo "  ✗ Missing: docs/demos/${demo}.md"
    ((ERRORS++))
  fi
done

# Check demo videos
echo
echo "Checking demo videos..."
EXPECTED_VIDEOS=(
  "demo-trimming"
  "demo-filter-grayscale"
  "demo-brightness"
  "demo-transitions"
  "demo-watermarks"
  "demo-speed-control"
  "demo-audio-fades"
  "demo-color-grading"
)

for video in "${EXPECTED_VIDEOS[@]}"; do
  VIDEO_PATH="videos/demos/${video}.mp4"
  if [ -f "$VIDEO_PATH" ]; then
    SIZE=$(du -h "$VIDEO_PATH" | cut -f1)
    echo "  ✓ $VIDEO_PATH ($SIZE)"

    # Warn if > 3MB
    SIZE_BYTES=$(stat -c%s "$VIDEO_PATH" 2>/dev/null || stat -f%z "$VIDEO_PATH" 2>/dev/null)
    if [ -n "$SIZE_BYTES" ]; then
      SIZE_MB=$((SIZE_BYTES / 1024 / 1024))
      if [ $SIZE_MB -gt 3 ]; then
        echo "    ⚠ Warning: File is ${SIZE_MB}MB (recommended < 2MB)"
      fi
    fi
  else
    echo "  ✗ Missing: $VIDEO_PATH"
    ((ERRORS++))
  fi
done

# Check navigation
echo
echo "Checking navigation..."
if grep -q "Speed Control" docs/_sidebar.md; then
  echo "  ✓ Sidebar includes new demos"
else
  echo "  ✗ Sidebar not updated"
  ((ERRORS++))
fi

# Check guides directory
echo
echo "Checking guides..."
if [ -d "docs/guides" ]; then
  echo "  ✓ guides directory exists"
  if [ -f "docs/guides/troubleshooting.md" ]; then
    echo "  ✓ troubleshooting.md exists"
  else
    echo "  ✗ troubleshooting.md missing"
    ((ERRORS++))
  fi
else
  echo "  ✗ guides directory missing"
  ((ERRORS++))
fi

echo
if [ $ERRORS -eq 0 ]; then
  echo "✓✓✓ All checks passed! ✓✓✓"
  exit 0
else
  echo "✗✗✗ Found $ERRORS error(s) ✗✗✗"
  exit 1
fi
