import pathlib

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource([str(pathlib.Path(
                get_package_share_directory('slam_toolbox')).joinpath('launch', 'online_async_launch.py'))]),
            launch_arguments = {
                'use_sim_time': 'False'
            }.items()
        ),
        Node(
            package='rviz2',
            executable='rviz2',
            name='slam',
            output={
                'stdout': 'log',
            },
            arguments=[
                '-d', str(pathlib.Path(__file__).parent.absolute().joinpath('config', 'slam.rviz')),
            ]
        ),
        Node(
            package='rqt_robot_steering',
            executable='rqt_robot_steering',
            name='slam',
            parameters=[{
               'default_topic': 'o3de_robot_control' 
            }],
            arguments=[
                '--force-discover', '--on-top'
            ]
        ),
        Node(
            package='pointcloud_to_laserscan',
            executable='pointcloud_to_laserscan_node',
            name='pc_to_laserscan',
            parameters=[{
                'min_height': 0.2,
                'max_height': 1.0
            }],
            remappings=[
                ('/cloud_in', '/pc'),
            ]
        )
    ])