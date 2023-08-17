#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

DOCKER_PATH=$DIR
ROS_VERSION=${ROS_VERSION:-noetic}

version="0.0.1" #"$(git describe --tags)$([ -z "$(git diff)" ] || echo "-untracked")"

CONTAINER_NAME=project11
CONTAINER_IMAGE=project11:$version
SHELL=/bin/bash


function build {
    docker build --build-arg ROS_VERSION=noetic -t ${CONTAINER_IMAGE} $DOCKER_PATH
    docker tag ${CONTAINER_IMAGE} ${CONTAINER_NAME}:latest
}

function run {

    docker stop $CONTAINER_NAME &> /dev/null
    docker rm $CONTAINER_NAME &> /dev/null
    xhost +local:*
    # PROJECT SPECIFIC
    docker run \
        -it \
        --privileged \
        --net=host \
        --env="DISPLAY=${DISPLAY}" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	    --volume="/home/maptastic/data:/data" \
        --workdir "/usr/local/ros" \
        --name $CONTAINER_NAME \
        $CONTAINER_IMAGE $SHELL
}

function attach {
    docker exec -it $CONTAINER_NAME $SHELL
}

function stop {
    docker stop $CONTAINER_NAME &> /dev/null
}

function clean {
    containers=$(docker ps -a -q -f status=exited)
    if [ -n "$containers" ]; then
        docker rm -v $containers > /dev/null
    fi
}

function remove {
    images=$(docker images -f "dangling=true" -q)
    if [ -n "$images" ]; then
        docker rmi $images > /dev/null
    fi
}

$1
