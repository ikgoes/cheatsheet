# firewall-cmd를 통한 port forwarding 설정

firewall-cmd --permanent --zone=public --add-forward-port=port=22000:proto=tcp:toport=22000:toaddr=150.150.103.201
firewall-cmd --permanent --zone=public --add-forward-port=port=22001:proto=tcp:toport=22001:toaddr=150.150.103.201
firewall-cmd --permanent --zone=public --add-forward-port=port=25:proto=tcp:toport=25:toaddr=10.94.38.119

firewall-cmd --permanent --zone=public --remove-forward-port=port=25:proto=tcp:toaddr=10.94.38.119
firewall-cmd --permanent --zone=public --add-forward-port=port=25:proto=tcp:toport=25:toaddr=10.94.38.119

firewall-cmd --permanent --zone=public --add-forward-port=port=22001:proto=tcp:toport=22001:toaddr=150.150.103.201
firewall-cmd --permanent --zone=public --add-forward-port=port=50000:proto=tcp:toport=50000:toaddr=10.94.36.243
firewall-cmd --reload

firewall-cmd --list-all | grep 50000 