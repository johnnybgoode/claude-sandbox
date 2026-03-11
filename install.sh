#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/johnnybgoode/claude-sandbox/main"
FILES=(Dockerfile docker-compose.yaml docker-entrypoint.sh sandbox.sh)

for file in "${FILES[@]}"; do
  curl -fsSL "$REPO/$file" -o "$file"
  echo "  $file"
done

chmod +x sandbox.sh docker-entrypoint.sh
echo "Done. Run ./sandbox.sh to start."
