#1.	Создайте сценарии *.ps1 для задач из labwork 2, проверьте их работоспостобность. Каждый сценарий должен иметь параметры.
#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding()]
param ([string] $File = "f:\Work\EPAM\Labworks\Test.txt")
Get-Service | Where-Object -Property Status -eq Running | Out-File $File
Get-ChildItem $File
Get-Content $File