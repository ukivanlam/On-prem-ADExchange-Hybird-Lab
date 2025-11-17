<#
建立 Exchange DAG
#>

$dagName = "DAG01"
$witnessServer = "WIN2019AD"
$witnessDir = "C:\DAGFileShareWitnesses\DAG01"
$dagIp = "192.168.10.70"

New-DatabaseAvailabilityGroup `
 -Name $dagName `
 -WitnessServer $witnessServer `
 -WitnessDirectory $witnessDir `
 -DatabaseAvailabilityGroupIPAddresses $dagIp

Add-DatabaseAvailabilityGroupServer -Identity $dagName -MailboxServer "MSEX2019"
Add-DatabaseAvailabilityGroupServer -Identity $dagName -MailboxServer "WIN-EX2019"

Get-DatabaseAvailabilityGroup $dagName | Format-List Name,Servers,WitnessServer
