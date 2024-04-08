# Runs checking number of powered on vms in remote pc

$secureString = 'Password' | ConvertTo-secureString -AsPlainText -Force
$credential = New-Object pscredential('administrator', $secureString)

$s = New-PSSession HOSTNAME -credential $credential

Invoke-Command -Session $s -ScriptBloc {Connect-VIServer -Server vcenter.vcenter.com -User 'administrator@vsphere.local' -Password 'password' | out-null}
Invoke-Command -Session $s -ScriptBloc {$VMs = Get-View -ViewType VirtualMachine}
Invoke-Command -Session $s -ScriptBloc {$Count = (@($VMs | Where { $_.Runtime.PowerState -eq "poweredOn"}).Count )}

echo $Count
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false