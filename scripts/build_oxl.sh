#!/usr/bin/env bash

set -euo pipefail

VERSION="$1"

cd "$(dirname "$0")/../versions/${VERSION}"

docker build -f Dockerfile_debian_openssl -t "oxlorg/haproxy:debian-quic-${VERSION}-openssl" --network=host --no-cache .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:debian-quic-${VERSION}-awslc" --network=host --no-cache .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:debian-quic-latest" --network=host .
docker build -f Dockerfile_debian_awslc -t "oxlorg/haproxy:latest" --network=host .

docker push "oxlorg/haproxy:debian-quic-${VERSION}-openssl"
docker push "oxlorg/haproxy:debian-quic-${VERSION}-awslc"
docker push "oxlorg/haproxy:debian-quic-latest"
docker push "oxlorg/haproxy:latest"
