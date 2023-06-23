#!/bin/bash
sudo su
yum install -y nfs-utils
systemctl enable firewalld --now
systemctl status firewalld


firewall-cmd --add-service="nfs3" --permanent
firewall-cmd --add-service="rpc-bind" --permanent
firewall-cmd --add-service="mountd" --permanent
firewall-cmd --add-port=111/udp --permanent
firewall-cmd --add-port=2049/udp --permanent
firewall-cmd --zone=public --add-service=nfs --permanent

firewall-cmd --reload

systemctl enable nfs-server
systemctl start nfs-server

mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload
echo '/srv/share 192.168.56.11(rw,sync,root_squash,all_squash)' | tee /etc/exports.d/srv_share.exports
exportfs -a
systemctl restart nfs-server
