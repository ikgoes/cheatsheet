$secureString = 'password' | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object pscredential('region\administrator', $secureString)

$hostname = $args[0]
$Limit = $args[1]

$resultOK = "ScriptRes:Ok:"
$resultBad = "ScriptRes:Bad:"
$statusGood = "ScriptRes:CurrentLoginUser is "

$currentSessionCount = Invoke-Command -ComputerName $args[0] -ScriptBlock { (qwinsta).length-5 } -Credential $credential

if ($currentSessionCount -le $Limit) {
    echo $resultOK$currentSessionCount
} else {
    echo $resultBAD$currentSessionCount
}