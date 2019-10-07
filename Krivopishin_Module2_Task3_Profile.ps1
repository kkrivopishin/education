#2.	Работа с профилем
#2.1.	Создать профиль
#2.2.	В профиле изненить цвета в консоли PowerShell
#2.3.	Создать несколько собственных алиасов
#2.4.	Создать несколько констант
#2.5.	Изменить текущую папку
#2.6.	Вывести приветсвие
#2.7.	Проверить применение профиля
New-Item -ItemType file -Path $profile –force
(Get-Host).UI.RawUI.BackgroundColor = "blue"
(Get-Host).UI.RawUI.ForegroundColor = "green"
Set-Alias -Name Updates Get-HotFix
Set-Alias -Name HelpMe Get-Help 
New-Variable -Name Const_3 -Value 1000
New-Variable -Name Const_6 -Value 1000000
Set-Location F:\Work\EPAM\education\
Write-Host "Good day, Comrade"
Test-Path $profile