#!/bin/bash

# Change the current directory to the script directory
pushd $(dirname $0) > /dev/null

rm -rf ohmyzsh && mkdir -p ohmyzsh && git init ohmyzsh &> /dev/null
git -C ohmyzsh remote add -t master origin https://github.com/ohmyzsh/ohmyzsh.git
git -C ohmyzsh config core.sparseCheckout true

cat <<EOL > ohmyzsh/.git/info/sparse-checkout
plugins/sudo
plugins/dirhistory
plugins/copybuffer
plugins/copypath
plugins/copyfile
plugins/docker
plugins/docker-compose
lib/clipboard.zsh
EOL

git -C ohmyzsh pull --depth 1 && rm -rf ohmyzsh/.git
# git -C ohmyzsh remote prune origin && git -C ohmyzsh repack && git -C ohmyzsh prune-packed && git -C ohmyzsh reflog expire --expire=1.day.ago && git -C ohmyzsh gc --aggressive
# # Use git sparse-checkout reapply in case you change anything

rm -rf zsh-autosuggestions && git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git && rm -rf zsh-autosuggestions/.git
rm -rf zsh-syntax-highlighting && git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git && rm -rf zsh-syntax-highlighting/.git
rm -rf zsh-you-should-use && git clone --depth 1 https://github.com/MichaelAquilina/zsh-you-should-use.git && rm -rf zsh-you-should-use/.git
rm -rf gradle-completion && git clone --depth 1 https://github.com/gradle/gradle-completion && rm -rf gradle-completion/.git

# Return to the previous directory
popd > /dev/null
