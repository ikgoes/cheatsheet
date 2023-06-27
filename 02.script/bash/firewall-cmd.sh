# firewall-cmd를 통한 port forwarding 설정

firewall-cmd --permanent --zone=public --add-forward-port=port=22000:proto=tcp:toport=22000:toaddr=150.150.103.201
firewall-cmd --permanent --zone=public --add-forward-port=port=22001:proto=tcp:toport=22001:toaddr=150.150.103.201
firewall-cmd --reload

firewall-cmd --list-all | grep 2200 