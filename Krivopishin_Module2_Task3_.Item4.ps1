$Count = 0
Get-ChildItem -Path C:\Windows\ -Recurse -File -Exclude *.tmp | ForEach-Object {$Count+=$_.Length}
$Count