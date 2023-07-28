#---------------------------------------------------#
# Add DNS A name record

Add-DnsServerResourceRecordA -Name "mgmt_dellsw1" -ZoneName "a.b.com" -AllowUpdateAny -IPv4Address "20.124.41.151"  -CreatePtr
Add-DnsServerResourceRecordA -Name "gwINTERNET3" -ZoneName "a.b.com" -AllowUpdateAny -IPv4Address "30.4.140.29"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw01" -ZoneName "mi.a.b.com" -AllowUpdateAny -IPv4Address "123.45.67.173"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw02" -ZoneName "mi.a.b.com" -AllowUpdateAny -IPv4Address "123.45.67.174"  -CreatePtr
Add-DnsServerResourceRecordA -Name "igw03" -ZoneName "mi.a.b.com" -AllowUpdateAny -IPv4Address "123.45.67.175"  -CreatePtr
