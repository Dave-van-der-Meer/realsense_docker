#!/usr/bin/env bash

if [ ${#} -lt 1 ]; then
    #echo "Usage: ${0} <docker image> <cmd (optional)>"
    #exit 1
    IMG="local/realsense:foxy"
    # CMD="bash /launch/lunalab_leo03.bash"
    # CMD="bash"
    CMD="ros2 launch leorover_realsense ns_d455_launch.py"
fi

ENVS="--env ROS_NAMESPACE=${ROS_NAMESPACE}"
VOLUMES=""
if [ -n "${RMW_IMPLEMENTATION}" ]; then
    ENVS="${ENVS} --env RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION}"
fi
if [ -n "${CYCLONEDDS_URI}" ]; then
    ENVS="${ENVS} --env CYCLONEDDS_URI=${CYCLONEDDS_URI}"
    VOLUMES="${VOLUMES} --volume ${CYCLONEDDS_URI//file:\/\//}:${CYCLONEDDS_URI//file:\/\//}:ro"
fi
if [ -n "${FASTRTPS_DEFAULT_PROFILES_FILE}" ]; then
    ENVS="${ENVS} --env FASTRTPS_DEFAULT_PROFILES_FILE=${FASTRTPS_DEFAULT_PROFILES_FILE}"
    VOLUMES="${VOLUMES} --volume ${FASTRTPS_DEFAULT_PROFILES_FILE}:${FASTRTPS_DEFAULT_PROFILES_FILE}:ro"
fi
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
    --restart always -d
    --privileged
    --security-opt "seccomp=unconfined"
    --volume "/etc/localtime:/etc/localtime:ro"
    --volume "/dev:/dev"
    --volume "/home/xavier/ros2_ws/src/src-ros2-leo/leorover_realsense:/home/leo/ros2_ws/src/leorover_realsense"
    "${VOLUMES}"
    "${ENVS}"
    "${IMG}"
    "${CMD}"
)

echo -e "\033[1;30m${DOCKER_RUN_CMD[*]}\033[0m" | xargs

# shellcheck disable=SC2048
exec ${DOCKER_RUN_CMD[*]}
