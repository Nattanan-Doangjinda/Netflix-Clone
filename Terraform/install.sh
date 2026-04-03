#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg apt-transport-https software-properties-common default-jdk

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

usermod -aG docker ubuntu
systemctl enable docker
systemctl start docker

chmod 777 /var/run/docker.sock 

# Install Jenkins
echo "🚀 Installing Jenkins..."
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# เอา user jenkins เข้า group docker จะได้สั่ง build image ได้
usermod -aG docker jenkins

# Install SonarQube
echo "🔍 Starting SonarQube Container..."
# รอให้ Docker service สตาร์ทเสร็จสมบูรณ์ก่อนสั่งรัน Container
sleep 5 
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Finish & Summary
echo "========================================================"
echo "✅ Setup Complete!"
echo " Jenkins: http://44.212.44.228:8080"
echo " SonarQube: http://44.212.44.228:9000"
echo "========================================================"
echo "🔐 Your Jenkins Initial Admin Password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "========================================================"