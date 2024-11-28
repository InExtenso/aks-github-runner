#!/usr/bin/env bash
set -eEuo pipefail

ACTIONS_RUNNER_INPUT_NAME=$HOSTNAME
export RUNNER_ALLOW_RUNASROOT=1

TOKEN="$(curl -sS --request POST --url "https://api.github.com/orgs/InExtenso/actions/runners/registration-token" --header "authorization: Bearer ${GH_TOKEN}"  --header 'content-type: application/json' | jq -r .token)"
podman system service --time=0 unix:///var/run/docker.sock &
/actions-runner/config.sh --unattended --replace --work "/tmp" --url "$ACTIONS_RUNNER_INPUT_URL" --token "$TOKEN" --labels aks-runner,ubuntu-latest
/actions-runner/bin/runsvc.sh
