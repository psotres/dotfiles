## Install software dependencies in Ubuntu 24 LTS

```bash
curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin
sudo apt update && apt install -y mosh tmux zsh stow bat tree fd-find
 
sudo ln -s /usr/bin/batcat /usr/local/bin/bat
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
sudo ln -s ~/.fzf/bin/fzf*(x) /usr/local/bin/
 
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && sudo chmod +x /usr/local/bin/yq
```
