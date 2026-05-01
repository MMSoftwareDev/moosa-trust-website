#!/usr/bin/env bash
#
# convert-images.sh
# -----------------
# Converts the large hero/cause JPEGs into responsive WebP at three widths
# (480 / 960 / 1600). Run this once locally; the resulting *.webp files sit
# alongside the originals and are picked up by the <picture> elements in the
# HTML. Originals stay where they are as the JPEG fallback.
#
# Requirements:
#   - cwebp (libwebp). Install:
#       macOS:    brew install webp
#       Ubuntu:   sudo apt install webp
#       Windows:  https://developers.google.com/speed/webp/download
#
# Usage:
#   bash scripts/convert-images.sh
#
# After running:
#   git add *.webp
#   git commit -m "Add WebP variants for hero/cause images"
#   git push origin main

set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v cwebp >/dev/null 2>&1; then
  echo "ERROR: cwebp not found. Install libwebp (see header of this script)." >&2
  exit 1
fi

# Files to convert. Add new entries here as more large images are introduced.
SOURCES=(
  "about-main.jpg"
  "about-water.jpg"
  "water.jpg"
  "education.jpg"
  "relief.jpg"
)

WIDTHS=(480 960 1600)
QUALITY=80

for src in "${SOURCES[@]}"; do
  if [[ ! -f "$src" ]]; then
    echo "Skipping $src (not found)"
    continue
  fi
  base="${src%.jpg}"
  echo "Processing $src..."
  for w in "${WIDTHS[@]}"; do
    out="${base}-${w}.webp"
    cwebp -q "$QUALITY" -resize "$w" 0 "$src" -o "$out" 2>/dev/null
    echo "  -> $out"
  done
  # Also produce a full-size WebP for src fallback
  cwebp -q "$QUALITY" "$src" -o "${base}.webp" 2>/dev/null
  echo "  -> ${base}.webp"
done

echo
echo "Done. Commit the new *.webp files and push:"
echo "  git add *.webp"
echo "  git commit -m 'Add WebP variants for hero/cause images'"
echo "  git push origin main"
