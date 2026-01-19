#!/bin/bash

set -euo pipefail

# Usage: compile.sh <cv_yaml_file>
# Generates a CV from the provided YAML file.

show_usage() {
  echo "Usage: $0 <cv_yaml_file>" >&2
  echo "  -h, --help    Show this help and exit" >&2
}

positional=()

for arg in "$@"; do
  case "$arg" in
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

# Render the CV
echo "Rendering for: '$CV_FILE'"
uv run rendercv render "$CV_FILE"

echo "Rendercv command finished successfully."