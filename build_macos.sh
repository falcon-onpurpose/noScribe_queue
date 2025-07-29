#!/bin/bash

echo "=== BUILDING NOSCRIBE FOR MACOS ==="
echo "Project size before build:"
du -sh .

echo "=== CLEANING OLD BUILDS ==="
rm -rf pyinstaller/dist/ pyinstaller/build/ pyinstaller/temp_dmg/

echo "=== BUILDING WITH OPTIMIZED SPEC ==="
cd pyinstaller
pyinstaller noScribe_optimized_macOS.spec

echo "=== CHECKING BUILD SIZE ==="
du -sh dist/noScribe/

echo "=== CREATING DMG WITH APPLICATIONS FOLDER ==="
mkdir -p temp_dmg
cp -r dist/noScribe.app temp_dmg/
ln -s /Applications temp_dmg/Applications

echo "=== CREATING DMG ==="
hdiutil create -volname "noScribe" -srcfolder temp_dmg -ov -format UDZO ../dist/noScribe.dmg

echo "=== CLEANING UP ==="
rm -rf temp_dmg

echo "=== BUILD COMPLETE ==="
echo "DMG location: ../dist/noScribe.dmg"
ls -la ../dist/noScribe.dmg

echo "=== PROJECT SIZE AFTER BUILD ==="
cd ..
du -sh . 