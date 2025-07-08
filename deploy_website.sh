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
    # Initial commit
    git add .
    git commit -m "Initial photography site deployment"
    git push origin main
else
    # Check if remote exists and has content
    if ! git ls-remote --exit-code origin main >/dev/null 2>&1; then
        echo "🔧 Remote repository is empty, doing initial push..."
        git add .
        git commit -m "Initial photography site deployment"
        git push origin main
    else
        # Check if there are any changes
        if git diff --quiet && git diff --cached --quiet; then
            echo "📝 No changes detected, skipping deployment"
            cd ..
            echo "🎉 Photography deployment complete (no changes)!"
            exit 0
        fi
        
        # Add and commit changes
        echo "📝 Adding and committing changes..."
        git add .
        git commit -m "Update photography site - $(date '+%Y-%m-%d %H:%M:%S')"
        
        # Push to GitHub Pages repository (only changed files)
        echo "🌐 Pushing to GitHub Pages..."
        git push origin main
    fi
fi

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
