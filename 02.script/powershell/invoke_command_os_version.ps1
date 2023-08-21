$secureString = 'password' | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object pscredential('region\administrator', $secureString)

$hostnames = @("hostname1","hostname2","hostname3")

foreach ($item in hostnames){
    $Result = "Not Collected"
    $Result = Invoke-Command -ComputerName $item -ScriptBlock { (Get-WmiObject Win32_OperatingSystem).Caption } -Credential $credential
    Write-Host "Windows Version for $item : $Result" 
}