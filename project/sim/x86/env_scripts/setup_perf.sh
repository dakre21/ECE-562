#!/bin/bash

echo "Setting up perf environment... this is more dependent on linux kernel you are running"
sudo apt-get install linux-lts-utopic-tools-common
sudo apt-get install linux-tools-common
sudo apt-get install linux-tools-`uname -r`
echo "Now find the perf binary-- located in /usr/lib, create an alias and you'll be able to use it normally"
