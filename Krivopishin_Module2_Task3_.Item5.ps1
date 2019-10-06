#1.5.	Создать один скрипт, объединив 3 задачи:
#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
#1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
param ([parameter(mandatory=$true)] [string]$colorxml,[parameter(mandatory=$true)] [string]$colorcsv)
Get-HotFix | Export-Csv -Path f:\Work\EPAM\Labworks\hotfix.csv 
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft -Recurse| Export-Clixml -Path f:\Work\EPAM\Labworks\reestr.xml
Import-Csv -Path f:\Work\EPAM\Labworks\hotfix.csv | ForEach-Object {Write-Host $_ -ForegroundColor $colorcsv}
Import-Clixml -Path f:\Work\EPAM\Labworks\reestr.xml | ForEach-Object {Write-Host $_ -ForegroundColor $colorxml}