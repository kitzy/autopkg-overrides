# Add a new override

1) Make sure you’ve added upstream recipe repos locally:
```bash
autopkg repo-add https://github.com/autopkg/recipes
autopkg repo-add https://github.com/homebysix/recipes
```

Generate the override and embed trust:

```bash
./scripts/add_override.sh Firefox.pkg
# creates overrides/Firefox.pkg.recipe with ParentRecipe + ParentRecipeTrustInfo
```

(Optional) Tweak inputs in the override (e.g., NAME, DOWNLOAD_URL, etc.).

Add the recipe name to a list (e.g., recipe-lists/darwin-prod.txt):

```
Firefox.pkg
```

Commit and open a PR. CI will run Verify AutoPkg trust.

Tips

To inspect an override: `autopkg info overrides/Firefox.pkg.recipe`

To refresh trust after upstream changes: `autopkg update-trust-info overrides/Firefox.pkg.recipe`

Keep overrides minimal; prefer letting upstream recipes evolve.
