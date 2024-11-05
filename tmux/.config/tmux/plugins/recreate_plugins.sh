#!/bin/bash

# Change the current directory to the script directory
pushd $(dirname $0) > /dev/null

rm -rf tpm && git clone --depth 1 https://github.com/tmux-plugins/tpm && rm -rf tmp/.git

# Return to the previous directory
popd > /dev/null
