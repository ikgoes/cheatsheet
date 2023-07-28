isi nfs exports list
isi nfs exports delete <id>

# exports 할 zone이 ESXbackup일 경우,

isi nfs exports create --paths= /ifs/data/NFS/af   --all-dirs=true --map-retry=true --map-root=root  --zone=ESXbackup