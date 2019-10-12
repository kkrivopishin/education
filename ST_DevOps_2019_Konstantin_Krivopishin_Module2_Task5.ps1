#В задании используются виртуальные машины созданные в предыдущих модулях.
#1.	При помощи WMI перезагрузить все виртуальные машины.
$Cred = Get-Credential
$VMashines = @("Krivopishin_VM1", "Krivopishin_VM2", "Krivopishin_VM3")
foreach ($vm in $VMashines) {
    (Get-WmiObject -Class Win32_OperatingSystem -Credential $Cred -ComputerName $vm).Reboot()
}

#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере.
foreach ($vm in $VMashines) {
    Get-WmiObject Win32_service –computer $vm -Credential $cred -Authentication Negotiate
}
#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
Enable-PSRemoting
Set-Item wsman:localhost\client\trustedhosts -value *
#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
Enter-PSSession -ComputerName "Krivopishin_VM2" -Credential $Cred -Authentication Negotiate
#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
New-PSSessionConfigurationFile -Path .\NewOne.pssc -VisibleProviders Filesystem
Test-PSSessionConfigurationFile .\NewOne.pssc
$cred = Get-Credential
Register-PSSessionConfiguration -Name NewOne -Path .\NewOne.pssc -RunAsCredential $cred    -ShowSecurityDescriptorUI 