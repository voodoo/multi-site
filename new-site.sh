#!/bin/bash
# Create a new site from the template
# Usage: ./new-site.sh my-site-name

set -e

SITE_NAME="${1:?Usage: ./new-site.sh <site-name>}"
SITES_DIR="$(dirname "$0")/sites"
TEMPLATE_DIR="$SITES_DIR/site-template"
NEW_SITE_DIR="$SITES_DIR/$SITE_NAME"

if [ -d "$NEW_SITE_DIR" ]; then
  echo "Error: $NEW_SITE_DIR already exists"
  exit 1
fi

echo "Creating new site: $SITE_NAME"

# Copy template
cp -r "$TEMPLATE_DIR" "$NEW_SITE_DIR"

# Update package.json name
sed -i "s/\"site-template\"/\"$SITE_NAME\"/" "$NEW_SITE_DIR/package.json"

# Init git repo and link shared (use symlink for local dev, submodule for remote)
cd "$NEW_SITE_DIR"
git init

# For local development, symlink shared. When you push shared to GitHub, change to: git submodule add <github-url> shared
ln -s ../../shared shared

# Install dependencies
npm install

echo ""
echo "✅ Site created: sites/$SITE_NAME"
echo ""
echo "Next steps:"
echo "  cd sites/$SITE_NAME"
echo "  npm run dev"
echo ""
echo "Shared layouts/components are in ./shared/ (git submodule)"
echo "To update shared: cd shared && git pull origin main"
