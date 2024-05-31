#!/bin/bash

set -e
set -o pipefail

HOOK_NAME=$(basename "$0")

REPO_ROOT=$(git rev-parse --show-toplevel)
HOOKS_DIR="$REPO_ROOT/bin/hooks/$HOOK_NAME.hooks"
EXECUTABLE_HOOKS=$(find "$HOOKS_DIR" -perm +111 -type f)

echo "Executing '$HOOK_NAME' hooks..."
for CURRENT_HOOK in $EXECUTABLE_HOOKS
do
    echo "Current hook: $CURRENT_HOOK"
    $CURRENT_HOOK
done
