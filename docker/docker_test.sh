#!/usr/bin/env bash

if [ ${#} -lt 1 ]; then
    #echo "Usage: ${0} <docker image> <cmd (optional)>"
    #exit 1
    IMG="local/realsense:humble"
    CMD="bash"
    # CMD="ros2 launch leorover_realsense ns_d455_launch.py"

fi

ENVS="--env ROS_NAMESPACE=${ROS_NAMESPACE}"
if [ -n "${ROS_DOMAIN_ID}" ]; then
    ENVS="${ENVS} --env ROS_DOMAIN_ID=${ROS_DOMAIN_ID}"
fi
if [ -n "${ROS_LOCALHOST_ONLY}" ]; then
    ENVS="${ENVS} --env ROS_LOCALHOST_ONLY=${ROS_LOCALHOST_ONLY}"
fi

DOCKER_RUN_CMD=(
    docker run
    --interactive
    --tty
    --name "leo_realsense"
    --network host
    --ipc host
    --rm
    --privileged
    --security-opt "seccomp=unconfined"
    --volume "/etc/localtime:/etc/localtime:ro"
    --volume "/dev:/dev"
    --volume "${PWD}/../ros2_ws/src/leorover_realsense:/home/leo/ros2_ws/src/leorover_realsense"
    --volume "/dev/shm:/dev/shm"
    --env ROS_NAMESPACE=${ROS_NAMESPACE}
    --env ROS_DOMAIN_ID=${ROS_DOMAIN_ID}
    --env ROS_LOCALHOST_ONLY=${ROS_LOCALHOST_ONLY}
    "${ENVS}"
    "${IMG}"
    "${CMD}"
)

echo -e "\033[1;30m${DOCKER_RUN_CMD[*]}\033[0m" | xargs

# shellcheck disable=SC2048
exec ${DOCKER_RUN_CMD[*]}
