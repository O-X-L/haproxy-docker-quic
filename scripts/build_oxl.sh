#!/usr/bin/env bash

set -euo pipefail

VERSION="$1"

cd "$(dirname "$0")/../versions/${VERSION}"

docker build -f Dockerfile_debian_openssl -t "oxlorg/haproxy:${VERSION}-debian-quic-openssl" --network=host --no-cache .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:${VERSION}-debian-quic-awslc" --network=host --no-cache .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:debian-quic" --network=host .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:latest" --network=host .

docker push "oxlorg/haproxy:${VERSION}-debian-quic-openssl"
docker push "oxlorg/haproxy:${VERSION}-debian-quic-awslc"
docker push "oxlorg/haproxy:debian-quic"
docker push "oxlorg/haproxy:latest"
