#!/bin/bash

EXTRA=""

if [[ "${1}" = "-r" ]]; then
  EXTRA="--rmi all --remove-orphans"

  shift
fi

pushd "$(dirname "$0")/.."

docker-compose down ${EXTRA} "$@"

popd
