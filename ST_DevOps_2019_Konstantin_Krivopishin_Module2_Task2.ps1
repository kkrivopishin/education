#1.	Просмотреть содержимое ветви реeстра HKCU
Get-ChildItem  -Path  HKCU:\

#2.	Создать, переименовать, удалить каталог на локальном диске
New-Item -Path F:\Work\Study_Krivposhin -ItemType Directory
Rename-Item -Path F:\Work\Study_Krivposhin -NewName SK
Remove-Item -Path F:\Work\SK

#3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item -Path C:\M2T2_Krivopishin -ItemType Directory
New-PSDrive -Name "H" -PSProvider "FileSystem" -Root "c:\M2T2_Krivopishin"

#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | Where-Object -Property Status -eq Running | Out-File -FilePath H:\Test.txt
Get-ChildItem -Path H:
Get-Content -Path H:\Test.txt

#5.	Просуммировать все числовые значения переменных текущего сеанса.
$Sum = 0
(Get-Variable | Where-Object {$_.Value -is "Int32"}).Value | ForEach-Object {$_; $Sum+=$_}
$Sum

#6.	Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object CPU -Descending | Select-Object -First 6

#7.	Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
Get-Process | ForEach-Object {
    if (($_.vm /1Mb) -gt 100) {Write-Host -ForegroundColor Red $_.Name -Separator " - " ($_.vm/1Mb)}
    else {Write-Host -ForegroundColor Green $_.Name -Separator " - " ($_.vm/1Mb)}
    }

#8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
$Count = 0
Get-ChildItem -Path C:\Windows\ -Recurse -File -Exclude *.tmp | ForEach-Object 
{
   $Count+=$_.Length
}
$Count
#9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-ChildItem  -Path  HKLM:\SOFTWARE\Microsoft  -Recurse | Export-Csv -Path f:\Work\HKLM.csv

#10.	Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
Get-History | Export-Clixml -Path f:\Work\History.xml

#11.	Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Get-History | Get-Member
Import-Clixml -Path f:\Work\History.xml | ForEach-Object {$_.Commandline, $_.EndExecutionTime, $_.ExecutionStatus, $_.Id, $_.StartExecutionTime}

#12.	Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-PSDrive -Name "H" -PSProvider "FileSystem"
Remove-Item -Path C:\M2T2_Krivopishin -Recurse