#!/bin/bash
# CentOS, Oracle Linux

# install dependencies
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# install docker ce and related packages
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker && sudo systemctl enable docker

# download docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# check versions
sudo docker --version && docker-compose --version
