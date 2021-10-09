#!/bin/bash

pushd "$(dirname "$0")/.."

\
  USER_ID=$(id -u) \
  GROUP_ID=$(id -g) \
  DOCKER_GROUP_ID=$(ls -l -n /var/run/docker.sock | awk '{print $4}') \
  docker-compose up "$@" --remove-orphans

popd
