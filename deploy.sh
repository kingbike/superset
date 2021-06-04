#!/bin/sh

echo "==============Building image!=============="
sudo docker build -t superset-ext ./

echo "===============saving xx.tar==============="
sudo docker save -o xx.tar superset-ext
sudo chmod 777 xx.tar

echo "====================scp===================="
scp -o StrictHostKeyChecking=no ./xx.tar ubuntu@10.144.225.175:/home/ubuntu/superset-git/

echo "==Replace image & restart docker-compose==="
ssh -o StrictHostKeyChecking=no ubuntu@10.144.225.175 "docker load -i /home/ubuntu/superset-git/xx.tar; \
/home/ubuntu/superset-git/superset/docker-compose -f /home/ubuntu/superset-git/superset/docker-compose-non-dev.yml down; \
/home/ubuntu/superset-git/superset/docker-compose -f /home/ubuntu/superset-git/superset/docker-compose-non-dev.yml up -d;"

echo "===============remove local tar============"
sudo rm xx.tar





