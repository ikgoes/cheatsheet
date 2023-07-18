# centos 7.8
yum install net-snmp* -y
systemctl status snmpd
systemctl start snmpd; systemctl enable snmpd
vi /etc/snmp/snmpd.conf

# edit in snmpd.conf
# com2sec ConfigUser  (Access List : 172.12.0.0/16)  (Community String)
# group   ConfigGroup v2c ConfigUser
# view    all included .1 80
# access  ConfigGroup ""  any noauth  exact   all all all

systemctl restart snmpd
