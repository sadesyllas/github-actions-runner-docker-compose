#!/usr/bin/env bash

set -eEuo pipefail

REGISTRATION_TOKEN=$(curl -s -X POST -H "authorization: token ${REPO_TOKEN}" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/registration-token" | jq -r .token)

./config.sh remove --token "${REGISTRATION_TOKEN}"

./config.sh \
  --url "https://github.com/${REPO_OWNER}/${REPO_NAME}" \
  --token "${REGISTRATION_TOKEN}" \
  --name "${RUNNER_NAME}" \
  --unattended \
  --work workspace \
  --replace

./bin/runsvc.sh

./config.sh remove --token "${REGISTRATION_TOKEN}"
