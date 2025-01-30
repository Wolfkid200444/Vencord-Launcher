#!/usr/bin/env bash

BRANCH="${1:-stable}"

if [[ ! "$BRANCH" =~ ^(stable|canary|ptb)$ ]]; then
    echo "Invalid branch: $BRANCH. Please choose 'stable', 'canary', or 'ptb'."
    exit 1
fi

GITHUB_ORG="MeguminSama"
REPO_NAME="Vencord-Launcher"

LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$GITHUB_ORG/$REPO_NAME/releases/latest")

echo $LATEST_RELEASE
echo "h"
