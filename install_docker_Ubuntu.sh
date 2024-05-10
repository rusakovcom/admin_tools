#!/bin/bash
# Ubuntu 
# wget https://raw.githubusercontent.com/rusakovcom/docker/main/install_docker_Ubuntu.sh

sudo apt update
# install necessary dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
# add docker official gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# add the docker repository
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

# download docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# symbolic link
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# check versions
docker-compose --version && docker --version
