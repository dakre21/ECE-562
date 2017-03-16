#!/bin/bash

# Author: David Akre
# Date: 3/14/2017
# Description: Helper script to get local environment setup to run gem5

echo "Setup is for ubuntu based systems"
echo "If you're using RHEL change packet manager to yum"
echo "Installation process takes approximately 10 mins"
echo ""
echo "Installing scons"
sudo apt-get install scons
echo ""
echo "Installing swig"
echo ""
sudo apt-get install swig
echo ""
echo "Installing m4"
echo ""
sudo apt-get install m4
echo ""
echo "Installing zlib"
echo ""
sudo apt-get install --reinstall zlibc zlib1g zlib1g-dev
echo ""
echo "Installing protobuf"
echo ""
cd ~
git clone https://github.com/google/protobuf
echo ""
echo "Installing protobuf dependencies"
echo ""
sudo apt-get install autoconf automake libtool curl make g++ unzip
echo ""
cd protobuf
./autogen.sh
./configure --prefix=/usr
make
make check
sudo make install
sudo ldconfig 
echo ""
echo "Installing packages to improve gem5 performance"
echo ""
echo "Installing python-dev"
echo ""
sudo apt-get install python-dev
echo "Installing tcmalloc"
echo ""
sudo apt-get install tcmalloc
echo ""
echo "Installing mercurial if you want to pull in updates from source"
echo ""
sudo apt-get install mercurial
echo ""
