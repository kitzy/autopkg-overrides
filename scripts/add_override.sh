#!/usr/bin/env bash
set -euo pipefail
if [[ $# -lt 1 ]]; then
  echo "usage: $0 <RecipeName> [<RecipeName> ...]" >&2
  exit 2
fi

# Ensure upstream repos exist
autopkg repo-list >/dev/null || {
  echo "AutoPkg not initialized. Run 'autopkg repo-add …' first." >&2
  exit 1
}

mkdir -p overrides
for r in "$@"; do
  base="${r##*/}"
  out="overrides/${base}.recipe"
  # If a YAML override is preferred, change extension and add --format=yaml once supported in make-override.
  echo "Creating override: $out"
  autopkg make-override "$r" -o "$out"
  echo "Embedding trust info: $out"
  autopkg update-trust-info "$out"
  echo "OK: $out"
done
