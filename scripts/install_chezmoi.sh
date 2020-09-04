#!/bin/bash
git-latest-release-rpm() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" \
        | jq -r '.assets[] | select(.name | endswith("x86_64.rpm")).browser_download_url'
}

RPM_URL=$(git-latest-release-rpm twpayne/chezmoi)
sudo dnf install $RPM_URL
