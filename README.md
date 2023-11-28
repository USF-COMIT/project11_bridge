# Project11 Bridge

This package offers a way to use [CCOM JHC's](https://github.com/CCOMJHC) ROS1-bassed Project11 backseat driver framework on ROS2 platforms. &#x20;

### Motivation

Project11 targets Ubuntu 20.04 and ROS Noetic, the latest LTS of ROS1.   However, the first LTS release of ROS2 targets Ubuntu 22.04.   The goal of this project was to develop a portable way to support Project11 on ROS2 Platforms running Ubuntu 22.04 and later.   Additionally,  Project11 Bridge offers a way to incrementally update components of Project11 suite from ROS1 to ROS2.

### How it works

Project11 Bridge utilizes several technologies to maintain portability across Ubuntu versions and compatibility with ROS2.

* **Docker** is used to create a virtual environment which contains installations of **ROS1** and **ROS2.**
* **ROS1\_bridge** is used to translate all or select ROS1 messages to a ROS2 vehicle and vice versa

### Note about ROS versions

The current release of Project11 Bridge Targets Ubuntu 20.04, ROS1 Noetic and ROS2 Foxy.   If you are running Project11 Bridge in a docker container on a 22.04 system (ros2 Humble) or later you may have compatibility issues since ROS2 messages are not guaranteed to be compatible between versions of ROS2.

## Installation

### Step 1: Install Docker

* Follow the instructions here to install docker for Ubuntu:  [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)
* It is highly recommended that you complete the post install steps to configure your user with docker permissions:  [https://docs.docker.com/engine/install/linux-postinstall/](https://docs.docker.com/engine/install/linux-postinstall/)

### Step 2: Clone the repo

This project utilizes sub modules make sure to use this special command

```bash
git clone --recurse-submodules https://github.com/USF-COMIT/project11_bridge.git
```

### Step 3: Build it

Open a terminal and move to the root the `project11_bridge` directory the build the docker image with the following command.   This will take a little while.

```bash
./dockerize.sh build
```

### Step 4 : Run It

Then you can run the image.   This will start a ROS1 bridge that supports all of the Project11 messages as well as the built in ROS messages.    It will automatically bridge any broadcast topic between ROS1 and ROS2

```bash
./dockerize.sh run
```

Project 11 is running in a docker container which can run on any version of Ubuntu after 20.04.&#x20;

### Credits

This package was created by Kris Krasnosky of the [USF COMIT](https://github.com/USF-COMIT) group and offered under the BSD 2-clause License to mirror the license of Project11.

