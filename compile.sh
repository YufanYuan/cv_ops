#!/bin/bash

set -euo pipefail

# Usage: compile.sh [-w|--watch] <cv_yaml_file>
# Generates a CV from the provided YAML file. If -w/--watch is supplied,
# it will re-render on changes.

show_usage() {
  echo "Usage: $0 [-w|--watch] <cv_yaml_file>" >&2
  echo "  -w, --watch   Re-render on file changes" >&2
  echo "  -h, --help    Show this help and exit" >&2
}

watch_flag=false
positional=()

for arg in "$@"; do
  case "$arg" in
    -w|--watch) watch_flag=true ;;
    -h|--help) show_usage; exit 0 ;;
    *) positional+=("$arg") ;;
  esac
done

if [ ${#positional[@]} -lt 1 ]; then
  echo "Error: CV YAML file path is required." >&2
  show_usage
  exit 1
fi

CV_FILE="${positional[0]}"

# Initialize template if not present (idempotent).
if [ ! -f "_CV.yaml" ]; then
  uv run rendercv new "" --theme engineeringresumes || true
  rm -f _CV.yaml || true
fi

if $watch_flag; then
  echo "Rendering with watch enabled for: '$CV_FILE'"
  echo "Changes to the YAML will trigger re-render."
  uv run rendercv render --watch "$CV_FILE"
else
  echo "Rendering once (no watch) for: '$CV_FILE'"
  uv run rendercv render "$CV_FILE"
fi

echo "Rendercv command finished successfully."