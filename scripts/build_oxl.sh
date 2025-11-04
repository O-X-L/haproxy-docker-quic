#!/usr/bin/env bash

set -euo pipefail

VERSION="$1"

cd "$(dirname "$0")/../versions/${VERSION}"

docker build -f Dockerfile_debian -t "oxlorg/haproxy:debian-quic-${VERSION}" --network=host --no-cache .
docker build -f Dockerfile_debian -t "oxlorg/haproxy:debian-quic-latest" --network=host .

docker push "oxlorg/haproxy:debian-quic-${VERSION}"
docker push "oxlorg/haproxy:debian-quic-latest"
