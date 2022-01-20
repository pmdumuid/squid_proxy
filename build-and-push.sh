#!/usr/bin/env bash

set -x
set -e

SQUID_VERSION=3.5.27
BUILD_VERSION=${SQUID_VERSION}-build02
BUILD_VCS_REF=pmdumuid/${BUILD_VERSION}
cat Dockerfile | sed "s=__BUILD_VCS_REF__=$BUILD_VCS_REF=g" > Dockerfile.out

docker build . -t pierre-salrashid123-squidproxy:${SQUID_VERSION}-latest -f Dockerfile.out

docker tag pierre-salrashid123-squidproxy:${SQUID_VERSION}-latest pmdumuid/ssl-squid-proxy:${SQUID_VERSION}
docker tag pierre-salrashid123-squidproxy:${SQUID_VERSION}-latest pmdumuid/ssl-squid-proxy:${BUILD_VERSION}

docker push pmdumuid/ssl-squid-proxy:${SQUID_VERSION}
docker push pmdumuid/ssl-squid-proxy:${BUILD_VERSION}
git tag ${BUILD_VCS_REF}

git push ghpmd ${BUILD_VCS_REF}
git push ghpmd dev-${SQUID_VERSION}
