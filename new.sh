

#install docker
#curl -fsSL https://get.docker.com/ | sh
#sudo groupadd docker
#sudo usermod -aG docker ubuntu
#echo "docker_OPTS="--dns 8.8.8.8"" >> /etc/default/docker
docker build -t webcontainer https://alexkinuthia@github.com/alexkinuthia/basic.git
