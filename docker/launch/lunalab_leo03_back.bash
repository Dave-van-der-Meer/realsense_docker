#!/usr/bin/env bash

LAUNCH_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" &>/dev/null && pwd)"
CONFIG_DIR="$(dirname "${LAUNCH_DIR}")/config"

CAMERAS=(
    #lunalab_summit_xl_gen_d435
    #lunalab_summit_xl_gen_d455
    # lunalab_summit_xl_gen_l515
    lunalab_leo03_d455
)

for camera in "${CAMERAS[@]}"; do
    ROS2_RUN_CMD=(
        ros2 run
        realsense2_camera realsense2_camera_node
        --ros-args -r __ns:="/leo03"
        --ros-args --params-file "${CONFIG_DIR}/${camera}.yaml"
        # --ros-args -p json_file_path:="${CONFIG_DIR}/${camera}.json"
    )

    echo -e "\033[1;30mCamera node: ${ROS2_RUN_CMD[*]}\033[0m" | xargs

    # shellcheck disable=SC2048
    exec ${ROS2_RUN_CMD[*]} &
done

terminate_child_processes() {
    echo "Signal received. Terminating all child processes..."
    for job in $(jobs -p); do
        kill -TERM "$job" 2>/dev/null || echo -e "\033[31m$job could not be terminated...\033[0m" >&2
    done
}
trap terminate_child_processes SIGINT SIGTERM SIGQUIT

for job in $(jobs -p); do
    wait "$job"
done
