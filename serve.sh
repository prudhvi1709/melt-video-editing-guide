#!/bin/bash

# MELT Video Editing Guide - Local Server
# Serves documentation on http://localhost:3000

echo "🎥 MELT Video Editing Guide"
echo "=========================="
echo ""

# Check if docsify-cli is installed
if ! command -v docsify &> /dev/null; then
    echo "❌ docsify-cli is not installed"
    echo ""
    echo "Install it with:"
    echo "  npm install -g docsify-cli"
    echo ""
    echo "Or run:"
    echo "  npm install && npm start"
    exit 1
fi

echo "✅ Starting documentation server..."
echo ""
echo "📚 Documentation will be available at:"
echo "   http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

docsify serve docs
