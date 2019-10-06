#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл.
param ([string] $Fproc = "f:\Work\EPAM\Labworks\Processes.txt")
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Out-File $Fproc