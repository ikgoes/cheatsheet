#---------------------------------------------------#
# Get Uptime
# Check if the server has been rebooted

$d1 = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
$d2 = Get-Date
$d1.LastBootUpTime -lt $d2.AddDays(-1)
$d1.LastBootUpTime -lt $d2.AddHours(-1)

#---------------------------------------------------#
# NFS Mount

mount -o anon 192.168.1.100:/mnt/share Z:
net use /delete Z:

#---------------------------------------------------#