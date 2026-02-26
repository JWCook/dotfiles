#!/usr/bin/env fish

set script_dir (dirname (dirname (status filename)))
source $script_dir/debian/deb_utils.fish
set repo gazatu/im-emoji-picker

# Find input framework
if command -v ibus >/dev/null
    set input_framework ibus
else if command -v fcitx5 >/dev/null
    set input_framework fcitx5
else
    echo "no input method framework found" && exit 1
end

# Find artifact URL
echo "Finding artifact for $DISTRO_ID $VERSION_ID ($input_framework)..."
set release_json $(mktemp --suffix=.json)
curl -s "https://api.github.com/repos/$repo/releases/latest" -o "$release_json"
set pkg_url (jq -r ".assets | .[] | .browser_download_url | select(. | (test(\"$DISTRO_ID\") and test(\"$VERSION_ID\") and test(\"$input_framework\")))" "$release_json")
if test -z "$pkg_url"
    echo "No artifact found" && exit 1
else
    echo "Found: $pkg_url"
end

set artifact_path "/tmp/"(basename "$pkg_url")
curl -sL "$pkg_url" -o "$artifact_path"
sudo apt install -y "$artifact_path" && rm $artifact_path && rm $release_json
