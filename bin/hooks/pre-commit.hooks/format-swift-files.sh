#!/bin/bash

set -e
set -o pipefail

function verify_swiftformat_installation() {
  if ! which swiftformat > /dev/null; then
    echo "warning: swiftformat not installed, skipping..."
    exit 0
  fi
}

function check_if_merge_commit() {
  if [[ $(git rev-parse -q --verify MERGE_HEAD) ]]; then
    echo "This is a merge commit. Will not run to avoid unintended changes."
    exit 0
  fi
}

function format_swift_files() {
  AUTHOR=$(git config user.name)
  HEADER="\n{file}\nLast modified by '$AUTHOR' in {year}.\n"

  # Run only for Swift staged files.
  git diff --staged --name-only --diff-filter=d | while read FILE; do 
    if [[ "${FILE##*.}" == "swift" ]]; then
      swiftformat "$FILE" --verbose --header "$HEADER" --self "init-only" --disable "elseOnSameLine"
      git add "$FILE"
    fi
  done
}

REPO_ROOT=$(git rev-parse --show-toplevel)
pushd "$REPO_ROOT"

verify_swiftformat_installation
check_if_merge_commit
format_swift_files

popd


