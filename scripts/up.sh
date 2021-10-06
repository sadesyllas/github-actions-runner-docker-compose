#!/bin/bash

pushd "$(dirname "$0")/.."

USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose up "$@" --remove-orphans

popd
