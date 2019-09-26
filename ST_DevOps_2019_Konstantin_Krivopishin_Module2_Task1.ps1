#1.	Получите справку о командлете справки
Get-Help -Name Get-Help

#2.	Пункт 1, но детальную справку, затем только примеры
Get-Help -Name Get-Help -Detailed
Get-Help -Name Get-Help -Examples

#3.	Получите справку о новых возможностях в PowerShell 4.0 (или выше)
Get-Help -Name PowerShell

Get-Help about_Windows_PowerShell_5.0

#4.	Получите все командлеты установки значений
Get-Command set-* -CommandType Cmdlet

#5.	Получить список команд работы с файлами
Get-Command *-item 

#6.	Получить список команд работы с объектами
Get-Command *-object

#7.	Получите список всех псевдонимов
Get-Alias 

#8.	Создайте свой псевдоним для любого командлета
Set-Alias -Name NOW -Value Get-Date
NOW

#9.	Просмотреть список методов и свойств объекта типа процесс
Get-Process | Get-Member -MemberType Methods, Property

#10.	Просмотреть список методов и свойств объекта типа строка
"Hello EveryBody" | Get-Member -MemberType Property, Methods

#11.	Получить список запущенных процессов, данные об определённом процессе
Get-Process
Get-Process -Name "winlogon"

#12.	Получить список всех сервисов, данные об определённом сервисе
Get-Service
Get-Service -Name "windows search" 

#13.	Получить список обновлений системы
Get-HotFix

#14.	Узнайте, какой язык установлен для UI Windows
Get-Host | Select-Object CurrentUICulture
#или
Get-UICulture -InformationVariable "language"

#15.	Получите текущее время и дату
Get-Date

#16.	Сгенерируйте случайное число (любым способом)
Get-Random

#17.	Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели.
(Get-Process -Name "explorer").StartTime.DateTime
(Get-Process -Name "explorer").StartTime.DayOfWeek

#18.	Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
#Открываем документ:
$Word = New-Object -ComObject Word.Application
$Word.Visible = $true
$file = "f:\work\resume\CV Krivopishin EPAM.docx"
$Word.Documents.Open($File)        
#Закрываем документ:
$Word.Quit()

#19.	Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
[int]$n = Read-Host ("Input n")
$S = 0
for ($i = 1; $i -le $n; $i++) {
    $S += $i * 3
    Write-Output "На шаге $i сумма S равна $S"
}

#20.	Напишите функцию для предыдущего задания. Запустите её на выполнение.
function Calculation_Of_S {
    param($n)
    $S = 0
    for ($i = 1; $i -le $n; $i++) {
        $S += $i * 3
        Write-Output "На шаге $i сумма S равна $S"
    }
}
    
Calculation_Of_S -n 3