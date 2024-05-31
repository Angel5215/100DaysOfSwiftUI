#!/bin/bash

set -e
set -o pipefail 

function install_hooks() {
    echo "Installing git hooks..."

    REPO_ROOT=$(git rev-parse --show-toplevel)
    HOOKS_DIR="$REPO_ROOT/bin/hooks"
    GIT_PATH="$REPO_ROOT/.git"
    GIT_HOOKS_PATH="$GIT_PATH/hooks"

    # Create standard path for git hooks if it doesn't exist yet (.git/hooks)
    mkdir -p $GIT_HOOKS_PATH

    # List all directories suffixed with `.hooks` in $HOOKS_DIR. These directories will contain
    # the desired hooks to be installed. For example `pre-commit.hooks` or `pre-push.hooks`.
    HOOKS_TO_INSTALL=$(ls "$HOOKS_DIR" | grep "\.hooks" | sed 's/\.hooks//')

    for HOOK in $HOOKS_TO_INSTALL
    do
        # Access Git default directory for hooks and remove previous installed hooks
        pushd "$GIT_HOOKS_PATH"
        rm -f "$HOOK"

        # Create a symbolic link to the `execute-hooks.sh` script that will execute a specific type of hook.
        ln -s "$HOOKS_DIR/execute-hooks.sh" "$HOOK"
        echo "Installed '$HOOK' hook." 
        popd
    done 
}

install_hooks