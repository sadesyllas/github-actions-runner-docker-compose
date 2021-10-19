#!/bin/bash

pushd "$(dirname "$0")/.."

\
  USER_ID=$(id -u) \
  GROUP_ID=$(id -g) \
  DOCKER_GROUP_ID=$(stat -c %g /var/run/docker.sock) \
  DOCKER_CONFIG_PATH="$(readlink -f ~/.docker)" \
  docker-compose up "$@" --remove-orphans

popd
