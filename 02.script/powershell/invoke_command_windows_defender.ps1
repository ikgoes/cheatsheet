$secureString = 'password' | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object pscredential('domain\administrator', $secureString)

$hostnames = @("hostname1","hostname2","hostname3")

foreach ($item in $hostnames){
    $Result = 0
    $Result = Invoke-Command -ComputerName $item -ScriptBlock { Get-MpComputerStatus | Select-Object -ExpandProperty AntivirusEnabled } -Credential $credential
    if ($Result -eq $true) {
        Write-Host "AntiVirus for $item : True"
    } else {
        Write-Host "AntiVirus for $item : False"
    }
}