#1.	Создайте сценарии *.ps1 для задач из labwork 2, проверьте их работоспостобность. Каждый сценарий должен иметь параметры.
#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding()]
param ([string] $File = "f:\Work\EPAM\Labworks\Test.txt")
Get-Service | Where-Object -Property Status -eq Running | Out-File $File
Get-ChildItem $File
Get-Content $File
#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
$Sum = 0
(Get-Variable | Where-Object { $_.Value -is "Int32" }).Value | ForEach-Object { $_; $Sum += $_ }
$Sum
#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл.
[CmdletBinding()]
param ([string] $Fproc = "f:\Work\EPAM\Labworks\Processes.txt")
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Out-File $Fproc
#1.3.1.	Организовать запуск скрипта каждые 10 минут
$T = New-JobTrigger -Once -At "10/6/2019 09:20:00" -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Hours 20)   
$Cred = Get-Credential Administrator
$Noption = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -Name Processes -FilePath f:\Work\EPAM\education\Krivopishin_Module2_Task3_.Item3.ps1 -Trigger $T -Credential $Cred -ScheduledJobOption $Noption
#1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)
$Count = 0
Get-ChildItem -Path C:\Windows\ -Recurse -File -Exclude *.tmp | ForEach-Object {$Count+=$_.Length}
$Count
#1.5.	Создать один скрипт, объединив 3 задачи:
#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
#1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
[CmdletBinding()]
param ([parameter(mandatory=$true)] [string]$colorxml,[parameter(mandatory=$true)] [string]$colorcsv)
Get-HotFix | Export-Csv -Path f:\Work\EPAM\Labworks\hotfix.csv 
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft -Recurse| Export-Clixml -Path f:\Work\EPAM\Labworks\reestr.xml
Import-Csv -Path f:\Work\EPAM\Labworks\hotfix.csv | ForEach-Object {Write-Host $_ -ForegroundColor $colorcsv}
Import-Clixml -Path f:\Work\EPAM\Labworks\reestr.xml | ForEach-Object {Write-Host $_ -ForegroundColor $colorxml}
#2.	Работа с профилем
#2.1.	Создать профиль
New-Item -ItemType file -Path $profile –force
#2.2.	В профиле изненить цвета в консоли PowerShell
(Get-Host).UI.RawUI.BackgroundColor = "blue"
(Get-Host).UI.RawUI.ForegroundColor = "green"
#2.3.	Создать несколько собственных алиасов
Set-Alias -Name Updates Get-HotFix
Set-Alias -Name HelpMe Get-Help 
#2.4.	Создать несколько констант
New-Variable -Name Const3 -Value 1000
New-Variable -Name Const6 -Value 1000000
#2.5.	Изменить текущую папку
Set-Location F:\Work\EPAM\education\
#2.6.	Вывести приветсвие
Write-Host "Good day, Comrade"
#2.7.	Проверить применение профиля
Test-Path $profile
#3.	Получить список всех доступных модулей
Get-Module -ListAvailable