#!/bin/bash

echo "=== BUILDING OPTIMIZED NOSCRIBE FOR MACOS ==="
echo "Project size before build:"
du -sh .

echo "=== CLEANING OLD BUILDS ==="
rm -rf dist/ build/ temp_dmg/

echo "=== BUILDING WITH OPTIMIZED SPEC ==="
pyinstaller noScribe_optimized_macOS_fixed.spec

echo "=== CHECKING INITIAL BUILD SIZE ==="
du -sh dist/noScribe/

echo "=== REMOVING DUPLICATE FILES ==="
# Remove duplicate model files from Frameworks
if [ -d "dist/noScribe.app/Contents/Frameworks/models" ]; then
    rm -rf dist/noScribe.app/Contents/Frameworks/models
    echo "Removed duplicate models from Frameworks"
fi

# Remove duplicate PyTorch libraries from Frameworks
if [ -d "dist/noScribe.app/Contents/Frameworks/torch" ]; then
    rm -rf dist/noScribe.app/Contents/Frameworks/torch
    echo "Removed duplicate torch from Frameworks"
fi

# Remove duplicate ffmpeg from Frameworks
if [ -f "dist/noScribe.app/Contents/Frameworks/ffmpeg" ]; then
    rm dist/noScribe.app/Contents/Frameworks/ffmpeg
    echo "Removed duplicate ffmpeg from Frameworks"
fi

# Remove duplicate libtorch files from Frameworks
find dist/noScribe.app/Contents/Frameworks/ -name "libtorch*.dylib" -delete 2>/dev/null
echo "Removed duplicate libtorch files from Frameworks"

echo "=== CHECKING OPTIMIZED BUILD SIZE ==="
du -sh dist/noScribe.app/

echo "=== CREATING DMG WITH APPLICATIONS FOLDER ==="
mkdir -p temp_dmg
cp -r dist/noScribe.app temp_dmg/
ln -s /Applications temp_dmg/Applications

echo "=== CREATING DMG ==="
hdiutil create -volname "noScribe" -srcfolder temp_dmg -ov -format UDZO ../dist/noScribe_optimized.dmg

echo "=== CLEANING UP ==="
rm -rf temp_dmg

echo "=== BUILD COMPLETE ==="
echo "Optimized DMG location: ../dist/noScribe_optimized.dmg"
ls -la ../dist/noScribe_optimized.dmg

echo "=== PROJECT SIZE AFTER BUILD ==="
cd ..
du -sh . 