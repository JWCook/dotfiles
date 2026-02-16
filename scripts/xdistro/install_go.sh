#!/usr/bin/env bash
VERSION=1.26.0
TMP_ARCHIVE=/tmp/go.tar.gz

wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz -O $TMP_ARCHIVE
rm -rf /usr/local/go && tar -C /usr/local -xzf $TMP_ARCHIVE
rm $TMP_ARCHIVE

rm -f /usr/local/bin/{go,gofmt}
ln -s /usr/local/go/bin/go /usr/local/bin/go
ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
