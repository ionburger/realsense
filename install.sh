#!/bin/bash
# script to install librealsense2 python bindings from source on debian based systems

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git cmake libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev libglfw3-dev build-essential
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
mkdir build 
cd build
cmake ../ -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=$(which python3)
make -j4
sudo make install
sudo make install-python
echo 'export PYTHONPATH=$PYTHONPATH:/usr/local/lib' >> ~/.bashrc
source ~/.bashrc
