#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" &>/dev/null && pwd)"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"

DOCKER_HOME="/root"
DOCKER_WS_DIR="${DOCKER_HOME}/ws"

MOUNT_VOLUMES=(
    "${PROJECT_DIR}/config:${DOCKER_WS_DIR}/config"
    "${PROJECT_DIR}/launch:${DOCKER_WS_DIR}/launch"
)

exec "${SCRIPT_DIR}/run.bash" "${MOUNT_VOLUMES[@]/#/"-v "}" "${@}"
