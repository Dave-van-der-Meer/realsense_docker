# realsense_docker

## Name
realsense_docker


## Description
This repostory contains the files to build a Docker image that contains the default ROS 2 package for the Realsense Camera. It currently uses the default `ros2_ws` of the robot to launch the `realsense_camera` ROS 2 package.


## Use
- Inside the repository, there is a file called `docker_build.sh`. When running this script, it will create a Docker image. 
- There is another script called `run.sh`. When running this script, a Docker container will be started that starts the Realsense Camera.
- This container will persist reboots and restarts automatically. To stop the container, use `docker stop leo_realsense` followed by `docker rm leo_realsense` to remove the stopped container before starting it again.


## Project status
This repository is fully functional. It requires some refactoring to clean up the repositories Docker files.

Things that need to be done:

- [x] Add `ros2_ws`
- [x] Add `leorover_realsense` package into this repository
- [x] Change shared volume from original `ros2_ws` to this internal `ros2_ws`
- [x] Change package name of `leorover_realsense` to a more genering name for easier re-use of the package
