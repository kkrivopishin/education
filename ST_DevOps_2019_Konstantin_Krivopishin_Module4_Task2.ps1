Import-Module ActiveDirectory

$ADUsers = Import-Csv -Path  "C:\Users\Administrator\Downloads\Users.csv"
foreach ($User in $ADUsers)
{
    $Firstname 	= $User.firstname
    $Lastname 	= $User.lastname
    $Department = $User.department
    $Password = $User.DefaultPassword
    $OU =  "OU=LAB_Users,DC=KK,DC=lab"
    New-ADUser `
    -Name "$Firstname $Lastname" `
    -Path $OU `
    -GivenName $Firstname `
    -Surname $Lastname `
    -Enabled $True `
    -Department $Department `
    -AccountPassword (convertto-securestring $Password -AsPlainText -Force) `
    -ChangePasswordAtLogon $True `
    -Verbose
}