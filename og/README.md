# Open Graph images

Each page on the site references a per-page Open Graph image at `/og/<slug>.jpg`,
shown when the page is shared on WhatsApp, iMessage, Twitter, LinkedIn, etc.

## Why SVG isn't enough

This folder contains SVG templates (`*.svg`) at 1200x630 — the standard OG
ratio. **Most messaging apps (WhatsApp, iMessage, Slack) do not render SVG OG
images.** They expect raster JPG or PNG. The SVGs here are design templates;
you (or a designer) need to export each one to a JPG with the same basename,
and commit it next to the SVG.

## How to convert

Pick whichever is easiest:

**Browser (zero install):**
1. Open the SVG file directly in Chrome/Safari/Firefox.
2. Take a 1200x630 screenshot (or use a browser extension like "GoFullPage").
3. Save as JPG with the same basename next to the SVG.

**Figma / Sketch / Affinity:**
1. Drag the SVG onto a 1200x630 frame.
2. Tweak fonts/colours if needed (the SVG uses system fonts as a fallback).
3. Export as JPG, quality 80.

**Command line (macOS):**
```bash
# Requires librsvg: brew install librsvg
for f in og/*.svg; do
  rsvg-convert -w 1200 -h 630 "$f" | convert - "${f%.svg}.jpg"
done
```

**Command line (Linux):**
```bash
sudo apt install librsvg2-bin imagemagick
for f in og/*.svg; do
  rsvg-convert -w 1200 -h 630 "$f" -o /tmp/og.png
  convert /tmp/og.png "${f%.svg}.jpg"
done
```

## What to commit

Once converted, commit the JPGs (not the SVGs — though keeping SVGs around
makes future edits easy):

```bash
git add og/*.jpg
git commit -m "Add per-page Open Graph images"
git push origin main
```

## Until then

Without the JPGs, social-media link previews will fall back to whatever the
shared platform decides — typically the global logo. The page still works
fine; only the preview card is degraded.

## Files

| Page                                  | OG image         |
| ------------------------------------- | ---------------- |
| Homepage `/`                          | `home.jpg`       |
| `/blog/`                              | `blog.jpg`       |
| `/blog/why-we-created-moosa-trust/`   | `blog-founder-letter.jpg` |
| `/projects/`                          | `projects.jpg`   |
| `/projects/sri-lanka-well/`           | `sri-lanka-well.jpg` |
| `/projects/education-initiative/`     | `education-initiative.jpg` |
| `/collection-box/`                    | `collection-box.jpg` |
| `/sitemap/`                           | `sitemap.jpg`    |
| `/privacy/`                           | `privacy.jpg`    |
| `/404.html`                           | (uses `home.jpg`) |
