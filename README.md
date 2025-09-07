# autopkg-overrides

Source-of-truth for AutoPkg **override files** and **trust info**, plus environment recipe lists.

- **No secrets** live here. This repo should be safe to make public.
- The **runner** repo consumes this as read-only, runs AutoPkg, uploads to Fleet, and opens PRs in `fleet-gitops`.

## Structure


recipe-lists/ # plain text lists of recipe names to run
darwin-prod.txt
overrides/ # your *.recipe or *.recipe.yaml overrides (with embedded trust)
.keep
scripts/ # local helper scripts (no CI secrets)
add_override.sh
docs/
ADD_OVERRIDE.md


## Quick start
1. Install AutoPkg locally: `brew install autopkg`
2. Add upstream recipe repos (one-time):
   ```bash
   autopkg repo-add https://github.com/autopkg/recipes
   autopkg repo-add https://github.com/homebysix/recipes
   autopkg repo-list
   ```

Add an override (example: Firefox.pkg):

./scripts/add_override.sh Firefox.pkg


This generates overrides/Firefox.pkg.recipe and embeds ParentRecipeTrustInfo.

Add the recipe name to a list (e.g., recipe-lists/darwin-prod.txt).

Commit + open PR. The runner repo will verify trust before building.

Trust model

We embed trust in each override file (field: ParentRecipeTrustInfo).

CI in this repo (verify-trust.yml) verifies only the overrides present.

If upstream recipes change, verify-trust fails; update trust with:

autopkg update-trust-info overrides/<Name>.recipe


Prefer minimal overrides (only inputs you actually need).

Conventions

Override filenames mirror the recipe name: Firefox.pkg.recipe, Slack.pkg.recipe.

Use .recipe (plist/XML) or .recipe.yaml—pick one and be consistent.

Keep recipe-lists/* deterministic; comments start with #.
