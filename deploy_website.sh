#!/bin/bash

# Navigate to the photography source directory
cd /Users/sunny/Library/CloudStorage/OneDrive-Personal/GitHub/photography-portfolio

echo "📸 Starting photography site deployment..."

# Build the site
echo "🔧 Building Hugo Gallery site..."
hugo

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "❌ Hugo build failed!"
    exit 1
fi

# Navigate to public directory
echo "📂 Navigating to public directory..."
cd public

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "🔧 Initializing git in public directory..."
    git init
    git remote add origin git@github.com:Sunnyhh/photography.git
    git config user.name "Sunny Lee"
    git config user.email "sunnyhh051008@gmail.com"
fi

# Add and commit changes
echo "📝 Adding and committing changes..."
git add .
git commit -m "Update photography site - $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"

# Push to GitHub Pages repository (this will replace the entire site)
echo "🌐 Pushing to GitHub Pages..."
git push origin main --force

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "✅ Photography deployment successful!"
    echo "📸 Your photography site should be live at: https://sunnyhh.github.io/photography"
else
    echo "❌ Photography deployment failed!"
    exit 1
fi

# Return to project root
cd ..

echo "🎉 Photography deployment complete!"
