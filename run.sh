#!/bin/sh

git clone https://github.com/mumble-voip/mumble.git repo

git clone https://github.com/SISheogorath/docker-murmur.git targetrepo

cd repo

officalLatest=$(git tag | tail -1)

cd ../targetrepo

containerLatest=$(cat Dockerfile | grep "ENV MURMUR_VERSION=" | sed 's/ENV MURMUR_VERSION=//')

[ ${officalLatest} != ${containerLatest} ] && [ $(../hub/bin/hub issue | grep "Update to latest murmur version ${officalLatest}" | wc -l) -eq 0 ] && ../hub/bin/hub issue create -m "Update to latest murmur version ${officalLatest}"
cd ..
rm -rf repo targetrepo
