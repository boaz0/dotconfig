#!/bin/bash

GO_VERSION=1.21.1
GO_URL=https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
[[ -f /tmp/go.tgz ]] || wget ${GO_URL} -O /tmp/go.tgz

sudo tar -C ~/.local/ -xzf /tmp/go.tgz

echo 'GOPATH="${HOME}/go"' >> ~/.bashrc
echo 'export PATH=$PATH:"${HOME}/.local/go/bin:${GOPATH}/bin"' >> ~/.bashrc
