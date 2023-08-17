#!/bin/bash

cd "$(dirname "$0")"

echo "Building ROS1 WS"
/bin/bash ros1_ws/build_ros1.sh
echo "building ROS2 WS"
/bin/bash ros2_ws/build_ros2.sh
/bin/bash ros2_ws/build_bridge.sh