#!/usr/bin/env bash
# deploy.sh — Publish the latest moxy_dashboard.html to GitHub Pages
# Usage: bash deploy.sh
set -e

DASHBOARD="moxy_dashboard.html"
TARGET="index.html"

if [ ! -f "$DASHBOARD" ]; then
  echo "ERROR: $DASHBOARD not found. Run this script from the repo root."
  exit 1
fi

# Sync working dashboard to the GitHub Pages entry point
cp "$DASHBOARD" "$TARGET"

# Stage only the file GitHub Pages cares about
git add "$TARGET"

# Commit only if there are staged changes
if git diff --cached --quiet; then
  echo "Nothing to commit — $TARGET is already up to date."
else
  git commit -m "Deploy dashboard update — $(date '+%Y-%m-%d')"
fi

git push origin main
echo "Done. GitHub Pages will update in ~30 seconds."
