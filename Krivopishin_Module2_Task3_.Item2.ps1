#1.2.	Просуммировать все числовые значения переменных среды Windows.(Параметры не нужны)
$Sum = 0
(Get-Variable | Where-Object {$_.Value -is "Int32"}).Value | ForEach-Object {$_; $Sum+=$_}
$Sum