sudo -i

service NetworkManager stop
chkconfig NetworkManager off
sudo cp /vagrant/respaldo/sysctl.conf /etc/sysctl.conf
sudo cp /vagrant/config /etc/selinux/config

service firewalld start
chkconfig firewalld on

firewall-cmd --zone=public --add-interface=eth2 --permanent
firewall-cmd --zone=internal --add-interface=eth1 --permanent

firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth2 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth2 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=80/udp --permanent
firewall-cmd --zone=internal --add-port=80/tcp --permanent
firewall-cmd --zone=internal --add-port=80/udp --permanent

firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --zone=internal --add-masquerade --permanent
firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.100.200 --permanent

service firewalld restart
firewall-cmd --reload
