#!/usr/bin/env bash
set -euo pipefail

if (( $# < 1 )); then
  echo "usage: $0 <RecipeName> [<RecipeName> ...]" >&2
  exit 2
fi

mkdir -p overrides

for r in "$@"; do
  # e.g., "Firefox.pkg" → "overrides/Firefox.pkg.recipe"
  base="${r##*/}"
  out="overrides/${base}.recipe"

  if [[ -f "$out" ]]; then
    echo "Override already exists: $out"
  else
    echo "Creating override in repo: $out"
    autopkg make-override --override-dir overrides "$r"
  fi

  echo "Embedding/refreshing trust info: $out"
  autopkg update-trust-info "$out"

  echo "OK: $out"
done

