# This is an auto generated Dockerfile for ros:ros1-bridge
# generated from docker_images_ros2/ros1_bridge/create_ros_ros1_bridge_image.Dockerfile.em
FROM ros:foxy-ros-base-focal

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

ENV ROS1_DISTRO noetic
ENV ROS2_DISTRO foxy

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS1_DISTRO}-ros-comm=1.16.0-1* \
    ros-${ROS1_DISTRO}-roscpp-tutorials=0.10.2-1* \
    ros-${ROS1_DISTRO}-rospy-tutorials=0.10.2-1* \
    ros-${ROS1_DISTRO}-geographic-msgs\
    && rm -rf /var/lib/apt/lists/*

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS2_DISTRO}-demo-nodes-cpp=0.9.4-1* \
    ros-${ROS2_DISTRO}-demo-nodes-py=0.9.4-1* \
    ros-${ROS2_DISTRO}-geographic-msgs\
    && rm -rf /var/lib/apt/lists/*

copy ./build.sh /usr/local/project11_bridge/
copy ./run.sh /usr/local/project11_bridge/

copy ./ros1_ws/src/ /usr/local/project11_bridge/ros1_ws/src/
copy ./ros1_ws/build_ros1.sh /usr/local/project11_bridge/ros1_ws/

copy ./ros2_ws/src/ /usr/local/project11_bridge/ros2_ws/src/
copy ./ros2_ws/build_*.sh /usr/local/project11_bridge/ros2_ws/

# grab all dependencies
RUN apt-get update
RUN rosdep update --include-eol-distros
RUN export DEBIAN_FRONTEND=noninteractive && rosdep install --from-paths /usr/local/project11_bridge/ros1_ws/src --ignore-src -r -y
RUN export DEBIAN_FRONTEND=noninteractive && rosdep install --from-paths /usr/local/project11_bridge/ros2_ws/src --ignore-src -r -y


RUN /usr/local/project11_bridge/build.sh


# setup entrypoint
#COPY ./ros_entrypoint.sh /

ENTRYPOINT /usr/local/project11_bridge/run.sh
