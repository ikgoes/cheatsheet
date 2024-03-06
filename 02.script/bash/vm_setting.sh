# set hostname
hostnamectl set-hostname HOSTNAME

# check device name with ifconfig
ifconfig 

# ip sett
# ip addr add 192.168.57.250/22 dev ens192
# ip addr show ens192
vi /etc/sysconfig/network-scripts/ifcfg-ens192
systemctl restart network

ip a

# reboot
init 6

#check repository
yum clean all
yum repolist
