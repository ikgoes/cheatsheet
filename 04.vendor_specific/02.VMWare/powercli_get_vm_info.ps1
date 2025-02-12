# get vm host, cluster, os, vcpu, memory, datastore, ip list in csv
$downloadPath = "C:\Users\test\vm_list1.csv"

Connect-VIServer -Server vcenter.vcenter.com -User 'administrator@vsphere.local' -Password 'password' | out-null}

$vms = Get-VM | Select-Object Name, PowerState, 
    @{Name="Host"; Expression={$_.VMHost.Name}}, 
    @{Name="Cluster"; Expression={(Get-Cluster -VM $_).Name}}, 
    @{Name="OS"; Expression={$_.Guest.OSFullName}}, 
    @{Name="vCPU"; Expression={$_.NumCpu}}, 
    @{Name="MemoryGB"; Expression={$_.MemoryGB}}, 
    @{Name="Datastore"; Expression={(Get-Datastore -RelatedObject $_ | ForEach-Object { $_.Name }) -join ", "}}, 
    @{Name="DatastoreCapacityGB"; Expression={(Get-Datastore -RelatedObject $_ | ForEach-Object { "$($_.Name), $($_.CapacityGB)GB" }) -join ", "}}, 
    @{Name="IP"; Expression={($_.Guest.IPAddress -join ", ")}}

# 결과 출력
# $vms | Format-Table -AutoSize

$vms | Export-Csv -Path $downloadPath -NoTypeInformation -Encoding UTF8

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
