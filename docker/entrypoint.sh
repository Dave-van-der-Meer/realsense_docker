#!/bin/bash

set -e

export ROS2_INSTALL_PATH="/opt/ros/${ROS_DISTRO}"

# export ROS_NAMESPACE="leo03"
# export ROS_DOMAIN_ID=51

export ROS_NAMESPACE=${ROS_NAMESPACE}
export ROS_DOMAIN_ID=${ROS_DOMAIN_ID}

# Configure DDS
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export FASTRTPS_DEFAULT_PROFILES_FILE=/home/leo/config/fastrtps-profile.xml
# export RMW_FASTRTPS_USE_QOS_FROM_XML=1


# setup ros2 environment
cd /home/leo/ros2_ws
source "/opt/ros/${ROS_DISTRO}/setup.bash"
colcon build
source "/home/leo/ros2_ws/install/setup.bash"
#chmod +x "/leo/launch/lunalab_leo03.bash"
exec "$@"
