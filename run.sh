#!/bin/bash

cd "$(dirname "$0")"

source ros1_ws/devel/setup.bash
source ros2_ws/install/setup.bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
