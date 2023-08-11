#!/bin/bash

cd "$(dirname "$0")"

source /opt/ros/foxy/setup.bash

echo "building messages"
colcon build --symlink-install --packages-skip ros1_bridge
