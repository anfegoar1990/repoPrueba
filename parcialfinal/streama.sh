sudo -i

yum -y update
yum -y install wget
yum install vim -y

wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

yum -y localinstall jdk-8u131-linux-x64.rpm

wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war

mkdir /opt/streama
mv streama-1.1.war /opt/streama/streama.war

java -jar /opt/streama/streama.war
mkdir /opt/streama/media
  
sudo cp /vagrant/respaldo/streama.service /etc/systemd/system/streama.service

systemctl start streama
systemctl enable streama
systemctl status streama
