#!/bin/bash

DEMO_NUM="$1"
DEMO_NAME="$2"
DEMO_TITLE="$3"

if [ -z "$DEMO_NUM" ] || [ -z "$DEMO_NAME" ] || [ -z "$DEMO_TITLE" ]; then
  echo "Usage: ./create-demo-page.sh <number> <name> <title>"
  echo "Example: ./create-demo-page.sh 05 speed-control 'Speed Control'"
  exit 1
fi

OUTPUT_FILE="docs/demos/${DEMO_NUM}-${DEMO_NAME}.md"

cat > "$OUTPUT_FILE" << EOF
# ${DEMO_TITLE} with MELT

Learn how to [add description here].

---

## Demo Video

<video width="100%" controls>
  <source src="../../videos/demos/demo-${DEMO_NAME}.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

**What you see:** [Description of what happens in the video]

---

## Command Used

\`\`\`bash
melt video.mp4 [command here] -consumer avformat:output.mp4
\`\`\`

**Breakdown:**
- \`parameter\` - Description
- \`parameter\` - Description

---

## Variations

### Variation 1
[Description]

\`\`\`bash
melt video.mp4 [variation] -consumer avformat:output.mp4
\`\`\`

---

## Tips

- **Tip 1:** Advice here
- **Tip 2:** Advice here
- **Tip 3:** Advice here

---

## Troubleshooting

**Problem:** Issue description

**Solution:** Solution description

---

## Next Steps

- [Related Demo →](link.md) - Description
- [Reference →](../reference/link.md) - Description

---

[← Back to Demos](README.md)
EOF

echo "✓ Created: $OUTPUT_FILE"
echo "Next: Edit the file to add specific content"
