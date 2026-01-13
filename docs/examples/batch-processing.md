# Batch Processing with MELT

Automate video processing tasks using shell scripts.

---

## Simple Batch Script

Save as `batch_process.sh`:

```bash
#!/bin/bash

# Process all MP4 files in directory
for file in *.mp4; do
  output="processed_${file}"
  echo "Processing: $file"

  melt "$file" \
    -filter greyscale \
    -consumer avformat:"$output" \
      vcodec=libx264 crf=23 \
      acodec=aac

  echo "Created: $output"
done

echo "All videos processed!"
```

**Usage:**
```bash
chmod +x batch_process.sh
./batch_process.sh
```

---

## Batch Trimming

Trim all videos to first 10 seconds:

```bash
#!/bin/bash

for file in *.mp4; do
  melt "$file" out=250 \
    -consumer avformat:"trimmed_${file}"
done
```

---

## Batch Watermarking

Add logo to all videos:

```bash
#!/bin/bash

LOGO="logo.png"

for file in *.mp4; do
  melt "$file" \
    -filter watermark:"$LOGO" \
      composite.halign=right \
      composite.valign=bottom \
    -consumer avformat:"watermarked_${file}"
done
```

---

## Batch with Parameters

```bash
#!/bin/bash

# Usage: ./script.sh 100 300
START=$1
END=$2

for file in *.mp4; do
  melt "$file" in=$START out=$END \
    -consumer avformat:"segment_${file}"
done
```

**Usage:**
```bash
./script.sh 100 300
```

---

## Parallel Processing

Use `parallel` for faster processing:

```bash
#!/bin/bash

export -f process_video

process_video() {
  file="$1"
  melt "$file" -filter greyscale \
    -consumer avformat:"processed_${file}"
}

# Process 4 videos at a time
parallel -j 4 process_video ::: *.mp4
```

---

## Progress Tracking

```bash
#!/bin/bash

total=$(ls -1 *.mp4 | wc -l)
current=0

for file in *.mp4; do
  ((current++))
  echo "[$current/$total] Processing: $file"

  melt "$file" -filter greyscale \
    -consumer avformat:"processed_${file}" \
    2>/dev/null
done
```

---

## Tips

- Test on one file before batch processing
- Use `-silent` flag to reduce output
- Consider disk space before processing many files
- Create backups of original files

---

[← Back to Examples](../examples/)
