#Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
$Ping = 0
Get-WmiObject -Class Win32_PingStatus -Filter "Address = '10.0.0.1'" -ComputerName Desktop | Select-Object -Property Responsetime |
ForEach-Object {$_.Responsetime
$Ping += $_.Responsetime}
Write-Host "Sum of responsed time the computer pinging:" $Ping