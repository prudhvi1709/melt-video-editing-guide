# MELT Video Editing Guide

> Comprehensive command-line video editing documentation using MELT (MLT Framework)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MLT Framework](https://img.shields.io/badge/MLT-Framework-brightgreen)](https://www.mltframework.org/)
[![Docsify](https://img.shields.io/badge/docs-Docsify-blue)](https://docsify.js.org/)

## 📚 Documentation

**Main Guide:** [SKILL.md](SKILL.md) - Complete command-line video editing reference in one file

**Live Site:** [View Documentation](https://prudhvi1709.github.io/melt-video-editing-guide/)

## 🎥 What is MELT?

MELT is a powerful command-line tool for video editing, part of the MLT (Media Lovin' Toolkit) multimedia framework. This guide provides practical examples and techniques for:

- ✂️ Trimming and cutting videos
- 🎨 Applying filters and effects
- 🔄 Creating transitions between clips
- 💧 Adding watermarks and overlays
- 🎚️ Processing audio
- 📹 Multi-track editing
- 🎬 Batch processing

## 🚀 Quick Start

### View Documentation Locally

```bash
# Install docsify-cli
npm install -g docsify-cli

# Serve documentation
docsify serve docs

# Open browser at http://localhost:3000
```

Or use the provided script:

```bash
npm install
npm start
```

## 📁 Project Structure

```
melt-video-editing-guide/
├── docs/                      # Documentation files
│   ├── README.md              # Main guide
│   ├── index.html             # Docsify configuration
│   ├── _sidebar.md            # Navigation sidebar
│   ├── _navbar.md             # Top navigation
│   ├── demos/                 # Video editing demos
│   │   ├── 01-trimming.md
│   │   ├── 02-filters.md
│   │   ├── 03-transitions.md
│   │   └── 04-watermarks.md
│   ├── reference/             # Reference documentation
│   │   ├── filters.md
│   │   ├── transitions.md
│   │   └── profiles.md
│   └── examples/              # Practical examples
│       ├── batch-processing.md
│       └── slideshow.md
├── videos/                    # Demo videos (local only)
│   └── demos/
│       ├── demo-trimming.mp4
│       ├── demo-filter-grayscale.mp4
│       └── demo-brightness.mp4
└── README.md                  # This file
```

## 🎯 Features

### Comprehensive Coverage
- Installation instructions for Linux, macOS
- 14+ video editing techniques
- 40+ command examples
- Interactive demos with embedded videos

### Demo Videos
- Real working examples
- Optimized for web (<2MB each)
- Embedded directly in documentation

### Practical Examples
- Batch processing scripts
- Slideshow creation
- Common workflows
- Troubleshooting guides

## 📖 Documentation Sections

### Getting Started
- [Installation](docs/README.md#installation)
- [Basic Usage](docs/README.md#what-is-melt)

### Demos
- [Trimming & Cutting](docs/demos/01-trimming.md)
- [Filters & Effects](docs/demos/02-filters.md)
- [Transitions](docs/demos/03-transitions.md)
- [Watermarks & Overlays](docs/demos/04-watermarks.md)

### Reference
- [Complete Filters List](docs/reference/filters.md)
- [All Transitions](docs/reference/transitions.md)
- [Video Profiles](docs/reference/profiles.md)

### Examples
- [Batch Processing Scripts](docs/examples/batch-processing.md)
- [Create Slideshow](docs/examples/slideshow.md)

## 🛠️ Development

### Prerequisites

- Node.js and npm
- MELT installed (for creating demo videos)
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/prudhvi1709/melt-video-editing-guide.git
cd melt-video-editing-guide

# Install dependencies
npm install

# Start local server
npm start
```

### Creating Demo Videos

Demo videos are created using MELT itself:

```bash
# Navigate to videos directory
cd videos/demos

# Create trimming demo
melt source.mp4 in=0 out=250 \
  -consumer avformat:demo-trimming.mp4 \
    vcodec=libx264 crf=28 preset=fast

# Create filter demo
melt source.mp4 in=0 out=250 -filter greyscale \
  -consumer avformat:demo-filter-grayscale.mp4
```

## 📦 Deployment

### GitHub Pages

1. Push code to GitHub
2. Go to repository Settings → Pages
3. Select Source: Branch `main`, Folder `/docs`
4. Save and wait for deployment

### Custom Domain

Add `CNAME` file to `docs/` folder:

```bash
echo "yourdomain.com" > docs/CNAME
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Areas for Contribution

- Additional demo videos
- More practical examples
- Translations
- Bug fixes
- Documentation improvements

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [MLT Framework](https://www.mltframework.org/) - The multimedia framework behind MELT
- [Docsify](https://docsify.js.org/) - Documentation site generator
- [Shotcut](https://www.shotcut.org/), [Kdenlive](https://kdenlive.org/) - Video editors built on MLT

## 📚 Resources

### Official MLT Resources
- [MLT Framework Website](https://www.mltframework.org/)
- [MLT Documentation](https://www.mltframework.org/docs/melt/)
- [MLT GitHub Repository](https://github.com/mltframework/mlt)

### Community Resources
- [Linux Magazine: Command-Line Melt](https://www.linux-magazine.com/Issues/2018/206/Command-Line-Melt)
- [MELT Man Page](https://linuxcommandlibrary.com/man/melt)

### Related Projects
- [Shotcut](https://www.shotcut.org/)
- [Kdenlive](https://kdenlive.org/)
- [Flowblade](https://jliljebl.github.io/flowblade/)

## 💬 Support

- 📧 Email: prudhvi.krovvidi@straive.com
- 🐛 Issues: [GitHub Issues](https://github.com/prudhvi1709/melt-video-editing-guide/issues)
- 💡 Discussions: [GitHub Discussions](https://github.com/prudhvi1709/melt-video-editing-guide/discussions)

## 📊 Project Stats

- 14+ Video Editing Techniques
- 40+ Command Examples
- 5+ Demo Videos
- 100% Open Source

---

**Made with ❤️ by [Prudhvi Krovvidi](https://github.com/prudhvi1709)**

**Last Updated:** 2026-01-13
