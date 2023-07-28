mkdir /mnt/nfs
sudo mount -t nfs -o vers=3 server_ip_or_hostname:/remote/export /mnt/nfs
printf "\t%s\t%s\t%s\t%s\t%s\t%s\n" "<server_ip_or_hostname>:/remote/export" "<local_mount_point>" "nfs" "vers=3" "0" "0" | sudo tee -a /etc/fstab

# Test mount

umount /mnt/nfs
mount /mnt/nfs