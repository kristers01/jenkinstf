#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker
echo 'installs docker and enables it'

sudo yum -y install git
echo 'installs git'

sudo aws configure set region eu-west-1
echo 'configures aws region'
sudo docker login -u AWS -p $(aws ecr get-login-password --region eu-west-1) 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage
sudo docker pull 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage:jenkinsecr
echo 'logs into ecr and pulls jenkins image'
sudo docker run -d --name jenkins --rm -p 8080:8080 148874668024.dkr.ecr.eu-west-1.amazonaws.com/jenkinsimage:jenkinsecr
echo 'runs jenkins image on port 8080'

sleep 20s
echo 'waits for 20 seconds'
mkdir ~/s3
echo 'creates directory to store jenkins job'
sudo aws s3 cp s3://jenkinsgitpush/s3 ~/s3 --recursive
echo 'pulls jenkins job folder from s3'
sudo chmod -R 777 ~/s3
echo 'gives permissions to jenkins job folder'
sudo docker cp ~/s3/jobs jenkins:/var/jenkins_home/jobs
sudo docker cp ~/s3/secrets jenkins:/var/jenkins_home
sudo docker cp ~/s3/secret.key jenkins:/var/jenkins_home
sudo docker cp ~/s3/credentials.xml jenkins:/var/jenkins_home
echo 'copies all the needed files to their locations'
sudo docker restart jenkins
echo 'restarts jenkins'