#!/usr/bin/env bash

BRANCH="${1:-stable}"

if [[ ! "$BRANCH" =~ ^(stable|canary|ptb)$ ]]; then
    echo "Invalid branch: $BRANCH. Please choose 'stable', 'canary', or 'ptb'."
    exit 1
fi

GITHUB_ORG="MeguminSama"
REPO_NAME="Vencord-Launcher"
ASSET_NAME="Vencord${BRANCH^}-"

LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$GITHUB_ORG/$REPO_NAME/releases/latest")

VERSION=$(echo "$LATEST_RELEASE" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "Failed to fetch the latest release. Please try again or open an issue on GitHub."
    exit 1
fi

ASSET_FILENAME="${ASSET_NAME}${VERSION}.tar.gz"

echo "Downloading Vencord $BRANCH $VERSION ($ASSET_FILENAME) from GitHub..."

DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep "browser_download_url" | grep "$ASSET_FILENAME" | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Failed to fetch the download URL. Please try again or open an issue on GitHub."
    exit 1
fi

TEMP_DIR=$(mktemp -d)

curl -L -o "$TEMP_DIR/$ASSET_FILENAME" "$DOWNLOAD_URL"

if [ $? -eq 0 ]; then
    echo "Download successful!"
else
    echo "Download failed. Please try again or open an issue on GitHub."
    exit 1
fi

echo "Extracting $ASSET_FILENAME..."

tar -xzf "$TEMP_DIR/$ASSET_FILENAME" -C "$TEMP_DIR"

if [ $? -eq 0 ]; then
    echo "Extraction successful!"
else
    echo "Extraction failed. Please try again or open an issue on GitHub."
    rm -r "$TEMP_DIR"
    exit 1
fi

echo "Installing Vencord $BRANCH $VERSION..."

sudo install -m 755 "$TEMP_DIR/vencord-$BRANCH" /usr/local/bin/
sudo install -m 644 "$TEMP_DIR/libvencord_launcher.so" /usr/local/lib/


sudo cp "$TEMP_DIR/libvencord_launcher.so" /usr/local/lib/

rm -r "$TEMP_DIR"
