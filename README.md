# ROS2 Warehouse demo

This project demonstrates the usage of ROS2 navigation along with the O3DE simulation.

## Requirements

Refer to the [O3DE System Requirements](https://www.o3de.org/docs/welcome-guide/requirements/) documentation to make sure that the system/hardware requirements are met.

This project has the following dependencies:

- [O3DE](https://github.com/o3de/o3de) 
- [ROS2 Gem](https://github.com/RobotecAI/o3de-ros2-gem)

To run the navigation example, two ROS2 packages are also required:
- [navigation2](https://github.com/ros-planning/navigation2)
- [slam_toolbox](https://github.com/SteveMacenski/slam_toolbox)

## Setup Instructions

The following steps will assume the following:

- All of the requirements are met.
- You have permissions to all of the github repos descripted in the requirements.
- The instructions will be based off of a common base folder: `$DEMO_BASE`. For the steps below, we will set `DEMO_BASE` to `~/github`.
- This current project has been fetched to `$DEMO_BASE`.
- You have ROS2 installed and environment is sourced.

### 1. Install ROS2 packages

```
sudo apt install ros-${ROS_DISTRO}-slam-toolbox
sudo apt install ros-${ROS_DISTRO}-navigation2
```


### 2. Clone O3DE (or install) and register the engine

```
$ cd $DEMO_BASE
~/github$ git clone https://github.com/o3de/o3de.git
~/github$ cd o3de
~/github/o3de$ git lfs install
~/github/o3de$ git lfs pull
~/github/o3de$ scripts/o3de.sh register --this-engine
```

### 3. Clone and register the ROS2 Gem locally

```
$ cd $DEMO_BASE
~/github$ git clone https://github.com/RobotecAI/o3de-ros2-gem.git
~/github$ $DEMO_BASE/o3de/scripts/o3de.sh register --gem-path $DEMO_BASE/o3de-ros2-gem
```

### 4. Register this project and build it

```
$ cd $DEMO_BASE
~/github$ o3de/scripts/o3de.sh register -pp $DEMO_BASE/Ros2WarehouseDemo
~/github$ cd Ros2WarehouseDemo
~/github/Ros2WarehouseDemo$ cmake -B build/linux -G "Ninja Multi-Config" -DLY_UNITY_BUILD=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLY_PARALLEL_LINK_JOBS=16 -DLY_STRIP_DEBUG_SYMBOLS=OFF
~/github/Ros2WarehouseDemo$ cmake --build build/linux --config profile --target Ros2WarehouseDemo.GameLauncher Editor
```

### 5. Launch Editor

```
$ cd $DEMO_BASE
~/github$ cd Ros2WarehouseDemo
~/github/Ros2WarehouseDemo$ cd build/linux/bin/profile
~/github/Ros2WarehouseDemo/build/linux/bin/profile$ ./Editor
```

## Running ROS2 navigation example

In this example, a simulation and the ROS2 navigation stack are running together. While running, map is being build, and the robot is controllable via target goal requests.

It is assumed that you have your ROS2 environment sourced.

### 1. Launch Editor

```
$ cd $DEMO_BASE
~/github$ cd Ros2WarehouseDemo
~/github/Ros2WarehouseDemo$ cd build/linux/bin/profile
~/github/Ros2WarehouseDemo/build/linux/bin/profile$ ./Editor
```

### 2. Run simulation

1. In `O3DE` editor open `DemoLevel`
1. Start simulation by clicking `Play Game` button or press `CTRL+G`

### 3. Run the navigation stack

```
~/github$ cd Ros2WarehouseDemo/launch
~/github/Ros2WarehouseDemo/launch$ ros2 launch navigation.launch.py
```

### 4. Set robot target goal

Use RViz GUI to set the goal by using the `2D Goal Pose` tool (upper toolbar). 

