# Contributing to MELT Video Editing Guide

Thank you for your interest in contributing! This guide will help you get started.

## 🎯 Ways to Contribute

1. **Add Demo Videos** - Create new demonstration videos
2. **Improve Documentation** - Fix typos, add examples, clarify instructions
3. **Submit Examples** - Share your MELT scripts and workflows
4. **Report Issues** - Found a bug or error? Let us know
5. **Translate** - Help translate the guide to other languages

## 🚀 Getting Started

### Prerequisites

- Git
- Node.js and npm
- MELT installed (for creating demo videos)

### Setup Development Environment

```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/melt-video-editing-guide.git
cd melt-video-editing-guide

# Install dependencies
npm install

# Start local server
npm start

# Open http://localhost:3000
```

## 📝 Making Changes

### Documentation

1. Edit markdown files in `docs/` directory
2. Preview changes locally (`npm start`)
3. Commit with clear message
4. Push and create Pull Request

### Adding Demo Videos

1. Create video using MELT in `videos/demos/`
2. Optimize for web (under 2MB, H.264)
3. Add corresponding documentation in `docs/demos/`
4. Update sidebar in `docs/_sidebar.md`

### Code Style

- Use clear, descriptive variable names
- Add comments for complex commands
- Follow existing markdown formatting
- Test all code examples before submitting

## 🎬 Creating Demo Videos

### Guidelines

- **Duration:** 10-30 seconds
- **Format:** MP4 (H.264)
- **Size:** Under 2-3 MB
- **Resolution:** 720p or 1080p
- **Content:** Single technique demonstration

### Example Creation

```bash
cd videos/demos

# Create demo
melt source.mp4 in=0 out=250 \
  -filter greyscale \
  -consumer avformat:demo-new-feature.mp4 \
    vcodec=libx264 crf=28 preset=fast

# Verify size
ls -lh demo-new-feature.mp4
```

### Optimization

```bash
# If video too large, increase CRF
melt source.mp4 in=0 out=250 \
  -consumer avformat:demo.mp4 \
    vcodec=libx264 crf=32 preset=fast
```

## 📄 Documentation Structure

```
docs/
├── README.md              # Main guide
├── demos/                 # Video demonstrations
│   └── XX-technique.md    # Individual demo pages
├── reference/             # Reference documentation
│   └── category.md        # Reference pages
└── examples/              # Practical examples
    └── use-case.md        # Example pages
```

## ✍️ Writing Guidelines

### Markdown Style

- Use clear headings (H1, H2, H3)
- Include code blocks with language syntax
- Add command explanations
- Provide practical examples

### Code Examples

```bash
# Good: Clear, commented, complete
melt video.mp4 \
  -filter greyscale \
  -consumer avformat:output.mp4 \
    vcodec=libx264 crf=23

# Avoid: Unclear, no context
melt video.mp4 -filter greyscale
```

### Demo Page Template

```markdown
# Technique Name

Brief description of what this demonstrates.

---

## Demo Video

<video width="100%" controls>
  <source src="../../videos/demos/demo-name.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

## Command Used

\`\`\`bash
melt input.mp4 [options] -consumer avformat:output.mp4
\`\`\`

## Explanation

Step-by-step breakdown...

## Variations

Alternative approaches...

## Tips

Helpful hints...

## Troubleshooting

Common issues and solutions...

---

[← Back to Demos](README.md)
```

## 🔍 Testing

Before submitting:

1. **Test locally:**
   ```bash
   npm start
   ```

2. **Verify all links work**
3. **Check video playback**
4. **Test code examples**
5. **Review for typos**

## 📤 Submitting Changes

### Commit Messages

Use clear, descriptive commit messages:

```bash
# Good
git commit -m "Add watermark positioning demo"
git commit -m "Fix typo in filters reference"
git commit -m "Update batch processing examples"

# Avoid
git commit -m "Update"
git commit -m "Fix stuff"
```

### Pull Request Process

1. **Create feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and commit**

3. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Open Pull Request on GitHub**

5. **Describe your changes:**
   - What was added/changed?
   - Why is it needed?
   - Any breaking changes?

## 🐛 Reporting Issues

When reporting bugs or issues:

1. Use GitHub Issues
2. Include:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - MELT version (`melt --version`)
   - Operating system

### Issue Template

```markdown
**Description:**
Brief description of the issue

**Steps to Reproduce:**
1. Step one
2. Step two
3. Step three

**Expected Behavior:**
What should happen

**Actual Behavior:**
What actually happens

**Environment:**
- OS: Ubuntu 22.04
- MELT Version: 7.x.x
- Browser: Chrome 120
```

## 💡 Suggesting Features

Feature requests are welcome! Please:

1. Check existing issues first
2. Describe the feature clearly
3. Explain use case
4. Provide examples if possible

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## ❓ Questions?

- Open an issue for general questions
- Email: prudhvi.krovvidi@straive.com
- Check existing documentation first

## 🙏 Thank You!

Your contributions make this project better for everyone!

---

**Happy Contributing!** 🎥✨
