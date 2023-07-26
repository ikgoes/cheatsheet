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
Add-DnsServerResourceRecordA -Name "igw01" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.173"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw02" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.174"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw03" -ZoneName "mi.dvc.lgensol.com" -AllowUpdateAny -IPv4Address "192.168.56.175"  -CreatePtr


#---------------------------------------------------#
# SNMP Setting

# Install SNMP Service
Install-WindowsFeature SNMP-Service -IncludeAllSubFeature -IncludeManagementTools

# Community String setup
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" -Name "CommunityString" -Value 4 -type DWord

# Access List setup
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "1" -Value "localhost" -type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "2" -Value "192.168.21.220" -type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "3" -Value "192.168.21.187" -type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "4" -Value "192.168.57.241" -type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "5" -Value "192.168.57.242" -type String
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "6" -Value "10.93.188.31" -type String


#---------------------------------------------------#

