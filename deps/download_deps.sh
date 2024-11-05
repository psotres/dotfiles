#!/bin/bash

# Change the current directory to the script directory
pushd $(dirname $0) > /dev/null

# Debian sid
# wget http://ftp.es.debian.org/debian/pool/main/t/tmux/tmux_3.5a-2_amd64.deb
# wget http://ftp.es.debian.org/debian/pool/main/m/mosh/mosh_1.4.0-1+b2_amd64.deb

# Ubuntu
wget -c https://launchpad.net/ubuntu/+source/tmux/3.5a-2/+build/29223766/+files/tmux_3.5a-2_amd64.deb
wget -c https://launchpad.net/ubuntu/+source/mosh/1.4.0-1ubuntu4/+build/28617529/+files/mosh_1.4.0-1ubuntu4_amd64.deb


# Return to the previous directory
popd > /dev/null

