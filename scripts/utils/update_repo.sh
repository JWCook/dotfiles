#!/usr/bin/env bash
REPO="{{REPO_DIR}}"
test -d "$REPO" && cd "$REPO" || (echo "❌ $REPO does not exist" && exit 1)

# Check for uncommitted changes
if ! git diff --quiet || ! git diff --quiet --cached; then
    echo "⚠️ Repository has uncommitted changes, stashing..."
    git stash save -q "auto-stash" || exit 1
    STASHED=1
fi

# Fetch and merge updates, and reapply any stashed changes
git fetch -q --all --prune
git pull -q --rebase && echo "✅ Updated $(basename $REPO)"
if test -n "$STASHED"; then git stash pop -q; fi
