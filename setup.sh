#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

mkdir -p input output

if [ ! -f input/cv.md ]; then
  cp input/cv.template.md input/cv.md
  echo "Created input/cv.md from template. Please edit it with your details."
else
  echo "input/cv.md already exists, skipping."
fi

echo ""
echo "Setup complete! Next steps:"
echo "  1. Edit input/cv.md with your CV"
echo "  2. Open Claude Code in this directory"
echo "  3. Run: /job-analyzer <linkedin-job-url>"
echo "  (Your user profile will be created interactively on first run)"
