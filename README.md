## Install software dependencies in Ubuntu 24 LTS

```bash
curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin
sudo apt update && sudo apt install -y mosh tmux zsh stow bat tree fd-find

sudo ln -s /usr/bin/batcat /usr/local/bin/bat
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
sudo ln -s ~/.fzf/bin/fzf*(x) /usr/local/bin/

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && sudo chmod +x /usr/local/bin/yq
```

**IMPORTANT FOR UBUNTU 22.04:** To enable color shell mosh 1.4.0 is needed. To install it on Ubuntu 22.04 you need to add this ppa: `sudo add-apt-repository ppa:keithw/mosh-dev`. Besides, Ubuntu 22.04 installs repos only include tmux 3.2, which do not support popups. You can install a newer version (from debian backport) using `wget -q http://ftp.es.debian.org/debian/pool/main/t/tmux/tmux_3.5a-2~bpo12+1_amd64.deb -O /tmp/tmux_3.5a-2~bpo12+1_amd64.deb && sudo apt install -y /tmp/tmux_3.5a-2~bpo12+1_amd64.deb`.



```bash
git clone https://github.com/psotres/dotfiles.git
cd dotfiles && ./zsh/.config/zsh/plugins/recreate_plugins.sh && ./tmux/.config/tmux/plugins/recreate_plugins.sh
stow gitconfig && stow oh-my-posh && stow tmux && stow zsh
```
