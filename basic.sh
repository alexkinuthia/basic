Def Bash


#! /bin/sh
### BEGIN INIT INFO
# Provides: bitsoko
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start bitsoko
# Description: This file starts and stops Bitsoko server
#
### END INIT INFO




cleanDocker(){




docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v




}




startTesting(){




        sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 18083
         sudo iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 18080
         sudo iptables -t nat -I PREROUTING -p tcp --dport 3306 -j REDIRECT --to-port 3306
        initializeDatabase;
        killall nodejs
        killall node
       node ~/server.js test;
}




starting(){








        sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 18083
         sudo iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 18080
         sudo iptables -t nat -I PREROUTING -p tcp --dport 3306 -j REDIRECT --to-port 3310
        initializeDatabase;
        killall nodejs
        killall node
        node ~/server.js start;
}




upload(){
        
        cd ~/
        git add --all && git commit -m 'update' && git push github --all
        cd
}




clone(){
        rm -rf ~/ && git clone git@github.com:wyklif/basic.git  && cd ~
        
        echo "updated basic"
}




initializeDatabase(){
docker start PROJdb
}




installDB(){




docker run -p 3306:3306 --name PROJdb -v ~/data/mysql:/var/lib/mysql -it -d mysql




}




installCerts(){




cd ~
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
./certbot-auto
#~/certbot-auto certonly --standalone -d DOMAIN.COM
~/certbot-auto certonly --email USERNAME@codeengine.co.ke --webroot -w ~/PROJ -d DOMAIN.com
#~/certbot-auto certonly --webroot -w /default -d DOMAIN.COM -d www.DOMAIN.COM






}




installSYS(){




#install docker
curl -fsSL https://get.docker.com/ | sh
sudo groupadd docker
sudo usermod -aG docker ubuntu
echo "docker_OPTS="--dns 8.8.8.8"" >> /etc/default/docker




#create certificates
installCerts;
mkdir certs && chmod 755 certs
installDB;




mkdir gitkey && chmod 755 gitkey
ssh-keygen -t rsa -b 4096 -f ~/gitkey/key -C "wycliffe.ottawa@yahoo.com" -q -N "" && curl -u "wyklif" --data "{\"title\":\"wyclifNode-`date +%Y%m%d%H%M%S`\",\"key\":\"`cat ~/gitkey/key.pub`\"}" https://api.github.com/user/keys
docker build git@github.com:wyklif/basic.git




cd ~ && rm -rf basic && git@github.com:wyklif/basic.git && cp ~/basic/Dockerfile ~/gitkey/Dockerfile && cd ~/gitkey/ && docker build -f ~/gitkey/Dockerfile -t basic:latest . && docker rm basic && docker run --privileged=true --name basic -p 8080:8080 -p 8083:8083 -v ~/gitkey/:/keys -v ~/certs:/certs -it basic /bin/bash




}




sudo cp ~/basic /etc/init.d/




clear
meiam=$(whoami)
sudo su








case "$1" in
 clone)
 clone;
   ;;
 test)
 startTesting;
   ;;
 start)
 starting;
   ;;
 upload)
 git add --all && git commit -m 'update' && git push -u origin master
   ;;
 stop)
  sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
  read -p "^^^ Stopped ^^^"
   ;;
 install)




   ;;
 *)
 
# set default feedback




echo "PROJ Initialized. what would you like to do? install-test-start-upload"
read action




if [ $action = clone ]
        then clone;
        /etc/init.d/PROJ
echo "cloning complete.. exiting."
exit
elif [ $action = setup ]
       then
sudo apt-get -y install git




cd ~
installSYS;
installDB;




elif [ $action = build ]
        then
         sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8083
         sudo iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8080
        
         upload ; node ~/PROJ/proj.js test;




elif [ $action = test ]
        then startTesting;
elif [ $action = upload ]
        then
        git add --all && git commit -m 'update' && git push --all google
elif [ $action = start ]
        then starting;
elif [ $action = install ]
        then installSYS;
        #installSIG;




        else echo "Oh no, dunno what to do! :-<"
fi








   ;;
esac




case "$action" in
 clone)
   clone;
   ;;
 test)
 startTesting;
   ;;
 start)
 starting;
   ;;
 upload)
 
        git add --all && git commit -m 'update' && git push -u origin master
   ;;
 stop)
   sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
  
read -p "^^^ Stopped ^^^"
   ;;
 install)




   ;;
 *)
 
   ;;
esac




exit
