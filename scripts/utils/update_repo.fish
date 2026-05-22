#!/usr/bin/env fish
set REPO "{{REPO_DIR}}"
set PATCH_FILE /tmp/(basename "$REPO")-autopatch-%self-(date +%s).patch

cd "$REPO"; or begin; echo "❌ $REPO does not exist"; exit 1; end

function cleanup --on-event fish_exit
    rm -f "$PATCH_FILE"
end

function restore_state
    git rebase --abort 2>/dev/null
    git reset --hard "$PRE_PULL_COMMIT"
    if set -q PATCHED
        git apply "$PATCH_FILE"; and echo "🔁 Patch reapplied"
    end
end

# Warn about untracked files
set UNTRACKED (git ls-files --others --exclude-standard)
if count $UNTRACKED >/dev/null
    echo "ℹ️  Untracked files (not protected):"
    printf "   • %s\n" $UNTRACKED
end

# Save patch if there are any changes
if not git diff --quiet; or not git diff --quiet --cached
    echo "⚠️  Uncommitted changes detected, saving patch..."
    git diff HEAD > "$PATCH_FILE"
    git reset -q --hard HEAD
    set PATCHED
end

git fetch -q --all --prune
set PRE_PULL_COMMIT (git rev-parse HEAD)

if not git pull -q --rebase
    echo "❌ Pull failed, restoring state"
    restore_state
    exit 1
end
echo "✅ Updated "(basename "$REPO")

if set -q PATCHED
    if git apply --check "$PATCH_FILE" 2>/dev/null
        git apply "$PATCH_FILE"; and echo "🔁 Patch reapplied"
    else
        echo "⚠️  Conflict detected, reverting pull"
        restore_state
        echo "ℹ️  Behind upstream; resolve conflicts manually and pull again"
    end
end
