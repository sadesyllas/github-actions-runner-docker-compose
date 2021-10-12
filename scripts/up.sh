#!/bin/bash

pushd "$(dirname "$0")/.."

DOCKER_GROUP_ID=$(stat -c %g /var/run/docker.sock) docker-compose up "$@" --remove-orphans

popd
