#!/bin/bash

cd "$(dirname "$0")"

source ../ros1_ws/devel/setup.bash
source install/setup.bash
echo "building ros1_bridge"
colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure