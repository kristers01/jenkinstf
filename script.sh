#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

sudo yum -y install git

sudo aws configure set region eu-west-1
sudo docker login -u AWS -p $(aws ecr get-login-password --region eu-west-1) 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage
sudo docker pull 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage:jenkinsecr
sudo docker run -d --name jenkins --rm -p 8080:8080 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage:jenkinsecr
sleep 20s
mkdir ~/s3
sudo aws s3 cp s3://jenkinsgitpush/s3 ~/s3 --recursive
sudo chmod -R 777 ~/s3
sudo docker cp ~/s3/jobs jenkins:/var/jenkins_home/jobs
sudo docker cp ~/s3/secrets jenkins:/var/jenkins_home
sudo docker cp ~/s3/secret.key jenkins:/var/jenkins_home
sudo docker cp ~/s3/credentials.xml jenkins:/var/jenkins_home
sudo docker restart jenkins