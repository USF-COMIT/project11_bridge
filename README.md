# Project11 Bridge

This package offers a way to use [CCOM JHC's](https://github.com/CCOMJHC) ROS1-bassed Project11 backseat driver framework on ROS2 platforms. &#x20;

### Motivation

Project11 targets Ubuntu 20.04 and ROS Noetic, the latest LTS of ROS1.   However, the first LTS release of ROS2 targets Ubuntu 22.04.   The goal of this project was to develop a portable way to support Project11 on ROS2 Platforms running Ubuntu 22.04 and later.   Additionally,  Project11 Bridge offers a way to incrementally update components of Project11 suite from ROS1 to ROS2.

### How it works

Project11 Bridge utilizes several technologies to maintain portability across Ubuntu versions and compatibility with ROS2.

* **Docker** is used to create a virtual environment which contains installations of **ROS1** and **ROS2.**
* **ROS1\_bridge** is used to translate all or select ROS1 messages to a ROS2 vehicle and vice versa

### Note about ROS versions



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

Then you can run the image.   This will effectively give you a ROS1 shell.

```bash
./dockerize.sh run
```

From there we can do normal Project11 things!  For example:

{% code lineNumbers="true" %}
```bash
source ${ROS1_WS_PATH}/devel/setup.bash
roslaunch project11_simulation sim_local.launch
```
{% endcode %}

and BAM,   Project 11 is running on Ubuntu 22.04!

## Using it with ROS2

Let's assume you are running the `sim_local.launch` file described in the last step.

begin by attaching another terminal to the project11 docker container. &#x20;

{% code lineNumbers="true" %}
```bash
cd <your project11_bridge directory>
./dockerize.sh attach
```
{% endcode %}

Now you have access to another shell in the docker container and source both ROS workspaces

{% code lineNumbers="true" %}
```bash
source ${ROS1_WS_PATH}/devel/setup.bash
source ${ROS2_WS_PATH}/install/setup.bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
```
{% endcode %}

