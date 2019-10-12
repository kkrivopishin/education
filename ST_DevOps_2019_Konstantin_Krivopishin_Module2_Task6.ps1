#1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
#1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-NetIPAddress
#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
(Get-NetAdapter).MacAddress
#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
$Servers = "Krivopishin_VM1", "Krivopishin_VM2", "Krivopishin_VM3"
$Credential = Get-Credential -UserName "Administrator" -Message "Local admin login on remote machine"
foreach ($Server in $Servers) {
    Invoke-Command -ComputerName $Server -ScriptBlock { (Get-NetAdapter).MacAddress } -Credential $Credential
}
#1.4.	Расшарить папку на компьютере
New-SmbShare -Path $PWD -Name SomeName -FullAccess Administrator
#1.5.	Удалить шару из п.1.4
Remove-SmbShare -Name SomeName -Force
#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [IPAddress]
    $NetMask,
    [Parameter(Mandatory)]
    [IPAddress]
    $IpAddress1,
    [Parameter(Mandatory)]
    [IPAddress]
    $IpAddress2
)
$Network1 = $IpAddress1.Address -band $NetMask.Address
$Network2 = $IpAddress2.Address -band $NetMask.Address
if ($Network1 -eq $Network2) { Write-Host -ForegroundColor Green "Both IPs in the same network" }
else { Write-Host -ForegroundColor Red "IPs are in different networks" }

#2.	Работа с Hyper-V
#2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
Get-Command -Module Hyper-V
#2.2.	Получить список виртуальных машин 
Get-VM | Format-List
#2.3.	Получить состояние имеющихся виртуальных машин
(Get-VM).State
#2.4.	Выключить виртуальную машину
Stop-VM 
#2.5.	Создать новую виртуальную машину
New-VM -Name NewVM -MemoryStartupBytes 1024000000 -Generation 1 -NoVHD
#2.6.	Создать динамический жесткий диск
New-VHD -Path .\Disk.vhd -Dynamic -SizeBytes 1024000000
#2.7.	Удалить созданную виртуальную машину
Remove-VM -Name NewVM -Force