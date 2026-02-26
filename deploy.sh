#!/bin/bash

# Manual deployment script for GitHub Pages
# This script builds the site and deploys it to the gh-pages branch

set -e

echo "🚀 Building portfolio site..."

# Build CSS
npm run build:css

# Build site
npm run build

echo "📦 Preparing for deployment..."

# Create a temporary git worktree for gh-pages branch
if [ -d "gh-pages" ]; then
  rm -rf gh-pages
fi

git worktree add gh-pages gh-pages || git checkout --orphan gh-pages

# Copy built files
cp -r _site/* gh-pages/

# Remove unnecessary files
find gh-pages -name '.git' -type d -exec rm -rf {} + 2>/dev/null || true
find gh-pages -name 'node_modules' -type d -exec rm -rf {} + 2>/dev/null || true
find gh-pages -name 'src' -type d -exec rm -rf {} + 2>/dev/null || true
find gh-pages -name '.eleventy.js' -type f -delete
find gh-pages -name 'tailwind.config.js' -type f -delete
find gh-pages -name 'postcss.config.js' -type f -delete
find gh-pages -name 'package.json' -type f -delete
find gh-pages -name 'package-lock.json' -type f -delete

cd gh-pages

# Commit and push
git add -A
git commit -m "Deploy to GitHub Pages" || echo "No changes to deploy"
git push origin gh-pages --force

cd ..

echo "✅ Deployment complete!"
echo "🌐 Your site will be available at: https://$(git config --get remote.origin.url | sed 's|^.*github.com[:/]\([^/]*/[^.]*\).*|\1|').github.io"