#!/bin/sh

VERSION=v0.13.0

case $TRAVIS_OS_NAME in
  linux)
    VARIANT=linux-x86_64
    ;;
  osx)
    VARIANT=osx-x86_64
    ;;
  windows)
    VARIANT=win64.exe
    ;;
esac

BINARY=grpcwebproxy-${VERSION}-${VARIANT}

wget https://github.com/improbable-eng/grpc-web/releases/download/${VERSION}/${BINARY}.zip -O /tmp/grpcwebproxy.zip
rm -rf /tmp/grpcwebproxy
mkdir /tmp/grpcwebproxy
pushd /tmp/grpcwebproxy
unzip /tmp/grpcwebproxy.zip
mv dist/${BINARY} ./grpcwebproxy
popd
