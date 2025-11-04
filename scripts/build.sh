#!/usr/bin/env bash

if [ -z "$2" ]
then
  echo "USAGE:"
  echo " 1 > Version"
  echo " 2 > System (debian/alpine)"
  exit 1
fi

set -euo pipefail

cd "$(dirname "$0")/.."
BASE_DIR="$(pwd)"

VERSION="$1"
SYSTEM="$2"

if [[ "$SYSTEM" != "debian" ]] # && [[ "$SYSTEM" != "alpine" ]]
then
  echo "ERROR: UNSUPPORTED SYSTEM"
  exit 1
fi

BUILD_PATH="./versions/${VERSION}"
if [ ! -d "$BUILD_PATH" ]
then
  echo "ERROR: UNSUPPORTED VERSION"
  cd versions
  ls
  exit 1
fi

cp 'shared/test.cfg' "$BUILD_PATH/"
cp 'shared/docker-entrypoint.sh' "$BUILD_PATH/"
cd "$BUILD_PATH"
docker build -f "Dockerfile_${SYSTEM}" -t "haproxy-local:${VERSION}-quic" --network=host --no-cache .
