#!/usr/bin/env bash
# Publish an HTML report to the GitHub Pages site.
# Usage: ./publish.sh <file.html> [name]
# Prints the public URL on success.
set -euo pipefail
cd "$(dirname "$0")"

src="${1:?usage: publish.sh <file.html> [name]}"
name="${2:-$(basename "$src" .html)}"
dest="${name}.html"

cp -f "$src" "$dest"
git add "$dest"
if git diff --cached --quiet; then
  echo "no changes to publish for $dest" >&2
else
  git commit -q -m "Publish benchmark report: $dest"
  git push -q origin main
fi
echo "https://turcottcharles.github.io/$dest"
