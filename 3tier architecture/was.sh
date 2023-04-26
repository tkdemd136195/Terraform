#!/bin/bash
#UserData for Amazon Linux 2
sudo yum -y update

#Install Java
sudo yum install -y java-1.8.0-openjdk.x86_64

#Install Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz

#unzip Tomcat
sudo tar xzf apache-tomcat-9.0.73.tar.gz
sudo rm -rf apache-tomcat-9.0.73.tar.gz

#Create alias for restart
echo 'alias restart="sh /restart.sh"' >> /root/.bashrc
source /root/.bashrc

#Create restart.sh script
echo '#!/bin/bash' | sudo tee /restart.sh > /dev/null
echo '/apache-tomcat-9.0.73/bin/shutdown.sh' | sudo tee -a /restart.sh > /dev/null
echo '/apache-tomcat-9.0.73/bin/startup.sh' | sudo tee -a /restart.sh > /dev/null
sudo chmod +x /restart.sh
