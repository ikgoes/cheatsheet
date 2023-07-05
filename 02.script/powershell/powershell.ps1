#---------------------------------------------------#
# Get Uptime
# Check if the server has been rebooted

$d1 = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
$d2 = Get-Date
$d1.LastBootUpTime -lt $d2.AddDays(-1)
$d1.LastBootUpTime -lt $d2.AddHours(-1)

#---------------------------------------------------#
# Add DNS A name record

Add-DnsServerResourceRecordA -Name "mgmt_dellsw1" -ZoneName "dvc.lgensol.com" -AllowUpdateAny -IPv4Address "10.94.41.151"  -CreatePtr
Add-DnsServerResourceRecordA -Name "gwINTERNET3" -ZoneName "dvc.lgensol.com" -AllowUpdateAny -IPv4Address "10.94.40.29"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw01" -ZoneName "uoh.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.60.173"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw02" -ZoneName "uoh.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.60.174"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw03" -ZoneName "uoh.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.60.175"  -CreatePtr


#---------------------------------------------------#