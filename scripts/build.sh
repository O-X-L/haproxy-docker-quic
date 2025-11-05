#!/usr/bin/env bash

if [ -z "$2" ]
then
  echo "USAGE:"
  echo " 1 > Version"
  echo " 2 > System (debian/alpine)"
  exit 1
fi

cd "$(dirname "$0")/.."
BASE_DIR="$(pwd)"

VERSION="$1"
SYSTEM="$2"

if [ -z "$3" ]
then
  CRYPTO_LIB="aws_lc"
else
  CRYPTO_LIB="$3"
fi

set -euo pipefail

if [[ "$SYSTEM" != "debian" ]] # && [[ "$SYSTEM" != "alpine" ]]
then
  echo "ERROR: UNSUPPORTED SYSTEM"
  exit 1
fi

if [[ "$CRYPTO_LIB" != "awslc" ]] && [[ "$CRYPTO_LIB" != "openssl" ]]
then
  echo "ERROR: UNSUPPORTED CRYPTO-LIB (requires dedicated dockerfile)"
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

cp 'shared/docker-entrypoint.sh' "$BUILD_PATH/"
cd "$BUILD_PATH"
docker build -f "Dockerfile_${SYSTEM}_${CRYPTO_LIB}" -t "haproxy-local:${VERSION}-quic" --network=host --no-cache .

echo '#########'
echo 'FINISHED:'
echo "Image => haproxy-local:${VERSION}-quic (with crypto-lib ${CRYPTO_LIB})"
echo '#########'
