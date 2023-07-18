# AD 
# Add-DnsServerResourceRecordA -Name "igw01" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.173"  -CreatePtr
# Add-DnsServerResourceRecordA -Name "igw02" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.174"  -CreatePtr
# Add-DnsServerResourceRecordA -Name "igw03" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.175"  -CreatePtr
# 
echo "192.168.56.173 igw01" >> /etc/hosts 
echo "192.168.56.174 igw02" >> /etc/hosts
echo "192.168.56.175 igw03" >> /etc/hosts

yum install -y pacemaker corosync pcs
systemctl enable firewalld; systemctl start firewalld
firewall-cmd --zone=public --permanent --add-port=2224/tcp;
firewall-cmd --zone=public --permanent --add-port=3121/tcp;
firewall-cmd --zone=public --permanent --add-port=5403/tcp;
firewall-cmd --zone=public --permanent --add-port=21064/tcp;
firewall-cmd --zone=public --permanent --add-port=9929/tcp;
firewall-cmd --zone=public --permanent --add-port=5404/udp;
firewall-cmd --zone=public --permanent --add-port=5405/udp;
firewall-cmd --zone=public --permanent --add-port=9929/udp;

firewall-cmd --permanent --add-service=high-availability; firewall-cmd --reload

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
pcs resource create VirtualIPprivate ocf:heartbeat:IPaddr2 ip=192.168.56.172 cidr_netmask=22 op monitor interval=30s
pcs resource create VirtualIPpublic ocf:heartbeat:IPaddr2 ip=10.93.188.22 cidr_netmask=24 op monitor interval=30s

pcs status
ip a

# stop one of the node in pcs cluster
# check with 'pcs status'
pcs cluster stop
pcs cluster start