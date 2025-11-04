#!/usr/bin/env bash

VERSION="3.2"

set -uo pipefail

if ! which docker
then
  echo "ERROR: DOCKER REQUIRED"
  exit 1
fi

cd "$(dirname "$0")/.."

function log() {
  echo ''
  echo '#################'
  echo "$1"
  echo '#################'
  echo ''
}

log 'BUILDING'
docker build -f Dockerfile_overrides -t "haproxy-local:${VERSION}-quic" --network=host --no-cache .

log 'STARTING'
docker run --rm --network=host -d --name haproxy-quic-local "haproxy-local:${VERSION}-quic"

log 'TESTING HTTP 1.1'
docker run --network=host -it --rm alpine/curl-http3 curl -v --http1.1 http://172.18.0.1:8080

log 'TESTING HTTP 2'
docker run --network=host -it --rm alpine/curl-http3 curl -v --insecure --http2 https://172.18.0.1:8443

log 'TESTING HTTP 3'
docker run --network=host -it --rm alpine/curl-http3 curl -v --insecure --http3 https://172.18.0.1:8443

log 'LOGS'
docker logs haproxy-quic-local | cat

log 'STOPPING'
docker stop haproxy-quic-local
