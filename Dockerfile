Def Docker


############################################################
# Dockerfile to build container
# Based on Ubuntu 16.04
############################################################




# Set the base image to Ubuntu
FROM ubuntu:16.04




# File Author / Maintainer
MAINTAINER wycliffe@codeengine.co.ke






# Update the repository sources list
RUN apt-get update




################## BEGIN INSTALLATION ######################




RUN cd ~ && apt-get install -y iptables libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++ libcap2-bin unzip zip curl git libssl-dev




RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -




RUN apt-get install -y nodejs




RUN cd ~ && npm install blob request mysql compression letsencrypt letsencrypt-cli letsencrypt-express letsencrypt@2.x le-store-certbot@2.x le-challenge-fs@2.x le-acme-core@2.x le-sni-auto@2.x http2 cheerio html2jade winston express dateformat socket.io forever jade node-minify geoip-lite node-minify LinusU/node-canvas canvas base64-img twit promised-io web-push moment moment-timezone tz-lookup nodemailer xoauth2 browserify rtc-switchboard eth-lightwallet && cd ~/node_modules/geoip-lite && npm run-script updatedb




#ADD key ~/.ssh/github_key




#RUN chmod 0700 ~/.ssh/github_key && eval $(ssh-agent -s) && ssh-add ~/.ssh/github_key




#RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config && echo " IdentityFile ~/.ssh/github_key" >> /etc/ssh/ssh_config && cd ~ && git clone https://github.com/wyklif/basic.git




# add github certificates
#RUN cp /.ssh/github_key.pub ~/.ssh/github_key.pub && cp /.ssh/github_key ~/.ssh/github_key




# add the bitsoko library
#RUN cd ~ && rm -rf ~/dev && git clone https://github.com/wyklif/basic.git && cd




# Create the default certificate directory
RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\`` && setcap cap_net_bind_service=+ep `readlink -f \`which nodejs\``
##################### INSTALLATION END #####################




# Expose the default port
EXPOSE 8083
EXPOSE 8080




# Default port to execute the entrypoint
#CMD




# Set default container command
ENTRYPOINT eval $(ssh-agent -s) && ssh-add /keys/key && echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /etc/ssh/ssh_config && echo " IdentityFile /keys/key" >> /etc/ssh/ssh_config && cd ~ && rm -rf ~/dev && git clone git@github.com:USERNAME/REPO.git && cd