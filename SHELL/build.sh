#!/usr/bin/env bash
# INSTALL DOCKER
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce d -y
sudo systemctl start docker
sudo systemctl enable docker

#CREATE DOCKER VOLUMES (FOR TIG STACK)
sudo docker volume create grafana-volume
sudo docker volume create influxdb-volume

# INSTALL DOCKER-COMPOSE
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# COPY ALL CONTENTS OF VAGRANT RSYNC FOLDER (/vagrant) TO CURRENT DIRECTORY
# DEFAULT PATH OF RSYNC SOURCE IS LOCATION OF VAGRANTFILE
cp -a /vagrant/* .

# START DOCKER CONTAINERS (TIG STACK)
sudo docker-compose up -d
