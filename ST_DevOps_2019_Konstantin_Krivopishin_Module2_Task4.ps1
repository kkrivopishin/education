#1.	Вывести список всех классов WMI на локальном компьютере. 
Get-WmiObject -List -ComputerName Desktop
#2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -Namespace "ROOT\cimv2" -List
#3.	Получить список классов работы с принтером.
Get-WmiObject -List | Where-Object { $_.name -match "print" } 
#4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *
#5.	Получить информацию о BIOS.
Get-WmiObject -Class Win32_BIOS
#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
$Logicaldisk = 0
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Deviceid, FreeSpace |
ForEach-Object { $_.Deviceid; $_.FreeSpace / 1Gb
    $Logicaldisk += $_.FreeSpace / 1Gb }
Write-Host "Sum of FreeSpace on Logical Disks:" $Logicaldisk
#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
$Ping = 0
Get-WmiObject -Class Win32_PingStatus -Filter "Address = '10.0.0.1'" -ComputerName Desktop | Select-Object -Property Responsetime |
ForEach-Object { $_.Responsetime
    $Ping += $_.Responsetime }
Write-Host "Sum of responsed time the computer pinging:" $Ping
#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version | Out-GridView
#9.	Выводить сообщение при каждом запуске приложения MS Word.
Register-wmievent –query "select * from __instancecreationevent
within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" -Action { Write-Host "Hello, Comrade" }