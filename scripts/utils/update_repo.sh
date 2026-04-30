#!/usr/bin/env bash
REPO="{{REPO_DIR}}"
PATCH_FILE="/tmp/$(basename "$REPO")-autopatch-$$-$(date +%s).patch"

cd "$REPO" || { echo "❌ $REPO does not exist"; exit 1; }

trap 'rm -f "$PATCH_FILE"' EXIT

restore_state() {
    git rebase --abort 2>/dev/null
    git reset --hard "$PRE_PULL_COMMIT"
    if [ "$PATCHED" -eq 1 ]; then
        git apply "$PATCH_FILE" && echo "🔁 Patch reapplied"
    fi
}

# Warn about untracked files
UNTRACKED=$(git ls-files --others --exclude-standard)
[ -n "$UNTRACKED" ] && echo "ℹ️  Untracked files (not protected):" && \
    echo "$UNTRACKED" | sed 's/^/   • /'

# Save patch if there are any changes
PATCHED=0
if ! git diff --quiet || ! git diff --quiet --cached; then
    echo "⚠️  Uncommitted changes detected, saving patch..."
    git diff HEAD > "$PATCH_FILE"
    git reset -q --hard HEAD
    PATCHED=1
fi

git fetch -q --all --prune
PRE_PULL_COMMIT=$(git rev-parse HEAD)

if ! git pull -q --rebase; then
    echo "❌ Pull failed, restoring state"
    restore_state
    exit 1
fi
echo "✅ Updated $(basename "$REPO")"

if [ "$PATCHED" -eq 1 ]; then
    if git apply --check "$PATCH_FILE" 2>/dev/null; then
        git apply "$PATCH_FILE" && echo "🔁 Patch reapplied"
    else
        echo "⚠️  Conflict detected, reverting pull"
        restore_state
        echo "ℹ️  Behind upstream; resolve conflicts manually and pull again"
    fi
fi
