#!/usr/bin/env bash
cat << EOF > /etc/sudoers.d/keep-proxies
Defaults env_keep += "http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY"
Defaults timestamp_timeout=120
EOF
