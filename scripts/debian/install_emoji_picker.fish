#!/usr/bin/env fish

set GH_OWNER "gazatu"
set GH_REPO "im-emoji-picker"
set DISTRO_ID (grep "^ID=" "/etc/os-release" | sed "s/ID=//" | sed "s/\"//g")
set DISTRO_VERSION_ID (grep "^VERSION_ID=" "/etc/os-release" | sed "s/VERSION_ID=//" | sed "s/\"//g")

if command -v ibus > /dev/null
    set FRAMEWORK "ibus"
else if command -v fcitx5 > /dev/null
    set FRAMEWORK "fcitx5"
else
    echo "no input method framework found"
    exit 1
end

# Find artifact URL
set RELEASE_JSON "/tmp/$GH_REPO-latest.json"
curl -s "https://api.github.com/repos/$GH_OWNER/$GH_REPO/releases/latest" -o "$RELEASE_JSON"
set URL (jq -r ".assets | .[] | .browser_download_url | select(. | (test(\"$DISTRO_ID\") and test(\"$DISTRO_VERSION_ID\") and test(\"$FRAMEWORK\")))" "$RELEASE_JSON")
if test -z "$URL"
    echo "No artifact found"
    exit 1
end
rm $RELEASE_JSON

set ARTIFACT_PATH "/tmp/"(basename "$URL")
curl -sL "$URL" -o "$ARTIFACT_PATH"
sudo apt install -y "$ARTIFACT_PATH"; and rm $ARTIFACT_PATH
