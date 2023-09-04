ip link add link ens1f0 name ens1f0.761 type vlan id 761
ip link set dev ens1f0.761 up
ip addr add 192.168.64.118/22 dev ens1f0.761
ip addr show ens1f0.761 

ping 192.168.64.1
