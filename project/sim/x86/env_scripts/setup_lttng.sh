#!/bin/bash

echo "Installing lttng"
sudo apt-add-repository ppa:lttng/stable-2.9
sudo apt-get update
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
cd ~
git clone git://git.lttng.org/lttng-ust.git
cd lttng-ust
./bootstrap
./configure --disable-man-pages
make
make install
cd ~

echo "Add the tracing group to your user in order for lttng to work"
