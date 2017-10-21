#!/usr/bin/env bash

if [ -z "${CI}" ]; then  # if CI is not empty, I am supposed to being running on jenkins.linecorp.com
    if [ "$(uname)" = "Linux" ] && [ "$(whoami)" != "root" ]; then
        echo "Must be root user to execute docker command"
        exit 1
    fi
fi

set -eu

repository=''

BIN_DIR="bin"

CONTAINER_NAME="isucon7"

# Setup
rm -rf "${BIN_DIR}" && mkdir -pv "${BIN_DIR}"

# Stop the container if they are running
set +e
docker stop "${CONTAINER_NAME}"
# usually we don't need to execute `docker rm`
docker rm "${CONTAINER_NAME}" > /dev/null 2>&1
set -e

GOARCH="amd64"
# GOOS="$(uname| tr '[A-Z]' '[a-z]') "

# Build automator-server
docker run --rm --name "${CONTAINER_NAME}" -e GOARCH=${GOARCH} -e GOOS=linux -e GOPATH=/go \
    -v "$(pwd)":/go -w /go golang \
    go build -v isubata

# EOF
