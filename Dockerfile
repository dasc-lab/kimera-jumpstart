FROM ros:melodic

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive

## install vim and tmux
RUN apt-get update && apt-get install -y --no-install-recommends \ 
  vim tmux \
  && rm -rf /var/lib/apt/lists/*
 

## install kimera/ros dependencies 
RUN apt-get update && apt-get install -y --no-install-recommends \
  cmake build-essential unzip pkg-config autoconf \
  libboost-all-dev \
  libjpeg-dev \ 
  libpng-dev \ 
  libtiff-dev \
  libvtk6-dev libgtk-3-dev \ 
  libatlas-base-dev gfortran \
  libparmetis-dev \
  python-wstool python-catkin-tools \
  libtbb-dev \ 
  && rm -rf /var/lib/apt/lists/*
  
RUN apt-get update && apt-get install -y libgoogle-glog-dev libgflags-dev
RUN apt-get update && apt-get install -y ros-melodic-interactive-markers ros-melodic-rviz ros-melodic-camera-info-manager ros-melodic-tf-conversions

RUN apt-get update && apt-get install -y ros-melodic-image-proc ros-melodic-interactive-markers ros-melodic-image-pipeline ros-melodic-image-common ros-melodic-image-transport-plugins
# ENV CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH}:/usr/lib/x86_64-linux-gnu/cmake/image_proc


#RUN git clone https://github.com/ros-perception/image_pipeline.git
  
#RUN git clone https://github.com/ros-visualization/interactive_markers.git

#RUN git clone https://github.com/ros-perception/image_common.git	

#RUN git clone https://github.com/ros-perception/image_transport_plugins.git
#ENV CMAKE_PREFIX_PATH /usr/lib/x86_64-linux-gnu/cmake/image_proc

# RUN apt-get update && apt-get install -y ros-melodic-image_pipeline 



RUN apt-get update && apt-get install -y --no-install-recommends \ 
  python-rosdep \
  && rm -rf /var/lib/apt/lists/*


# Update system dependencies for ROS
RUN rosdep fix-permissions && rosdep update


RUN apt-get update && apt-get install -y --no-install-recommends \ 
  python-rosinstall \ 
  python-rosinstall-generator \ 
  python-wstool \ 
  build-essential \ 
  python-catkin-tools \
  && rm -rf /var/lib/apt/lists/*
	
RUN apt-get update && apt-get install -y --no-install-recommends \ 
  ros-melodic-image-geometry \
  ros-melodic-pcl-ros \
  ros-melodic-cv-bridge \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
  ros-melodic-realsense2-camera \
  ros-melodic-realsense2-description \
  && rm -rf /var/lib/apt/lists/*

#RUN apt-get update && apt-get install -y ros-melodic-catkin_simple
RUN echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc
RUN echo 'source /root/catkin_ws/devel/setup.bash' >> ~/.bashrc
#RUN source ~/catkin_ws/devel/setup.bash


## add useful commands
RUN echo 'alias kimera_camera="roslaunch kimera_vio_ros rs_camera.launch"' >> ~/.bashrc
RUN echo 'alias kimera_launch="roslaunch kimera_vio_ros kimera_vio_ros_realsense_IR.launch"' >> ~/.bashrc
RUN echo 'alias kimera_rviz="rviz -d $(rospack find kimera_vio_ros)/rviz/kimera_vio_euroc.rviz"' >> ~/.bashrc


RUN apt-get update && apt-get install ros-melodic-rqt-common-plugins -y
