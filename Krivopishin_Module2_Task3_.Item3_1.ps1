#1.3.1.	Организовать запуск скрипта каждые 10 минут
$T = New-JobTrigger -Once -At "10/6/2019 09:20:00" -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Hours 20)   
$Cred = Get-Credential Administrator
$Noption = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -Name Processes -FilePath f:\Work\EPAM\education\Krivopishin_Module2_Task3_.Item3.ps1 -Trigger $T -Credential $Cred -ScheduledJobOption $Noption