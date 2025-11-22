#!/bin/bash

# PowerLytix - One-Command Installation
# Downloads complete project from GitHub

set -e

echo "🚀 PowerLytix Dashboard - Quick Installer"
echo "=========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    echo "Install git first: https://git-scm.com/downloads"
    exit 1
fi

# Installation directory
INSTALL_DIR="${1:-powerlytix-dashboard}"

# Check if directory exists
if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  Directory '$INSTALL_DIR' already exists"
    read -p "Delete and reinstall? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$INSTALL_DIR"
        echo "🗑️  Removed existing directory"
    else
        echo "❌ Installation cancelled"
        exit 1
    fi
fi

echo "📥 Cloning PowerLytix from GitHub..."
git clone https://github.com/velocity-venture/PowerLytix-Private-KPI-Dashboard.git "$INSTALL_DIR"

cd "$INSTALL_DIR"

echo ""
echo "✅ Installation complete!"
echo ""
echo "📦 Next steps:"
echo "   1. cd $INSTALL_DIR"
echo "   2. npm install"
echo "   3. cp .env.example .env"
echo "   4. Edit .env with your Supabase credentials"
echo "   5. npm run dev"
echo ""
echo "🌐 Your app will run at: http://localhost:3000"
echo ""
echo "📖 For deployment guide, see README.md"
echo ""
