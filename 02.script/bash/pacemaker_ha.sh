yum install -y pacemaker corosync pcs
systemctl enable firewalld; systemctl start firewalld
firewall-cmd --zone=public --permanent --add-part=2224/tcp;
firewall-cmd --zone=public --permanent --add-part=3121/tcp;
firewall-cmd --zone=public --permanent --add-part=5403/tcp;
firewall-cmd --zone=public --permanent --add-part=21064/tcp;
firewall-cmd --zone=public --permanent --add-part=9929/tcp;
firewall-cmd --zone=public --permanent --add-part=5404/udp;
firewall-cmd --zone=public --permanent --add-part=5405/udp;
firewall-cmd --zone=public --permanent --add-part=9929/udp;

firewall-cmd --permanent --add-servoce=high-availability; firewall-cmd --reload

systemctl enable pcsd.service; systemctl start pcsd.service
systemctl enable corosync.service; systemctl start corosync.service
systemctl enable pacemaker.service; systemctl start pacemaker.service

passwd hacluster

pcs cluster auth igw01 igw02 igw03  # set names on /etc/hosts
pcs cluster setup --name igw igw01 igw02 igw03
pcs cluster start --all
corosync-cfgtool -s
corosync-cmapctl | egrep -i members

pcs status corosync
pcs status

crm_verify -L -V
pcs property set stonith-enabled=false
crm_verify -L

# create VIP
pcs resource create VirtualIPprivate ocf:heartbeat:IPaddr2 ip=192.168.40.172 cidr_netmask=22 op monitor interval=30s

pcs status
ip a

pcs 
