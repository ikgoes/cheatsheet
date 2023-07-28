ip route add <ip>/<subnet_bit> via <gateway>

# permanently
echo "ip route add <ip>/<subnet_bit> via <gateway>" >> /etc/sysconfig/network-scripts/route-ens192