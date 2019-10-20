Invoke-Expression -Command "D:\Setup.exe /ConfigurationFile=E:\ConfigurationFile.INI /SAPWD= 'Kvm092019' /IAcceptSQLServerLicenseTerms"
New-NetFirewallRule -DisplayName "MS SQL Server TCP" -Name "MS SQL Server TCP" -LocalPort 1433 -Protocol TCP -Direction Inbound -Action Allow -Profile Any 
New-NetFirewallRule -DisplayName "RDP" -Name "RDP" -LocalPort 3389 -Protocol TCP -Direction Inbound -Action Allow -Profile Any 
$Instances = @()
$Instances += (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
foreach ($Instance in $Instances) {
    Write-Host "Computer name: $env:COMPUTERNAME; Instance name: $Instance"
}
$ChildFolder = Get-ChildItem "C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\" -Directory | Select-Object -Last 1 
[xml]$Discovery = Get-Content "$($ChildFolder.FullName)\SqlDiscoveryReport.xml"
$Discovery.ArrayOfDiscoveryInformation.DiscoveryInformation | Format-Table Instance, Feature
Get-NetFirewallRule -Name "RDP" | Get-NetFirewallPortFilter
Get-NetFirewallRule -Name "MS SQL Server TCP" | Get-NetFirewallPortFilter