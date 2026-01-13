#!/bin/bash

# Update video links in SKILL.md to GitHub release URLs
# Usage: ./update-video-links.sh <github-username> <release-tag>
# Example: ./update-video-links.sh prudhvi1709 v1.0.0

USERNAME="${1:-prudhvi1709}"
RELEASE="${2:-v1.0.0}"

BASE_URL="https://github.com/${USERNAME}/melt-video-editing-guide/releases/download/${RELEASE}"

echo "Updating video links in SKILL.md..."
echo "Release URL: ${BASE_URL}"
echo

# Update SKILL.md
sed -i.bak "s|videos/demos/demo-|${BASE_URL}/demo-|g" SKILL.md

# Update docs/README.md (copy of SKILL.md)
sed -i.bak "s|videos/demos/demo-|${BASE_URL}/demo-|g" docs/README.md

echo "✓ Updated SKILL.md"
echo "✓ Updated docs/README.md"
echo
echo "Backup files created: *.bak"
echo
echo "Review changes with:"
echo "  diff SKILL.md.bak SKILL.md"
echo
echo "If satisfied, commit and push:"
echo "  git add SKILL.md docs/README.md"
echo "  git commit -m 'Update video links to GitHub releases'"
echo "  git push"
