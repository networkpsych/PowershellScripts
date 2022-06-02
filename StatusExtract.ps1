Import-Module ActiveDirectory

$Dirpath = " "
$Pathme = Read-Host -Prompt 'File to read: '

try{
	$Groups = Get-Content -Path "$Dirpath\$Pathme"
}
catch {
	Write-Host "An error has occured"
	Write-Host $_
	}
	
# Filters accounts to True and False status
ForEach ($User in $Users)
{
	ForEach-Object {
		$User = Get-ADUser $User -Properties *
		if ( $User ){
			[PSCustomObject]@{
			UserName = $User.fullname
			UserID = $User.samaccountname
			Email = $User.principalname
			Enabled = $User.enabled
			}
		}
		else {
			Write-Host $User + "Does not exist"
		}
	}
}

# Use | Export-csv "YOUR FILE HERE" -NoTypeInformation

echo "`n"
