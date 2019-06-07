Import-Module activedirectory

$Dirpath = " "
$Pathme = Read-Host -Prompt 'Text file name' 

$Fileme = Read-Host -Prompt 'Project name' # name for csv file

$Groups = Get-Content -Path "$Dirpath\$Pathme"
# Filters accounts to True and False status

$Table = @()

$Record = @{
"Status" = ""
"Username" = ""
}
$i = 1
$i = 1
ForEach ($Group in $Groups)
{
	Write-Progress -Activity "Search in progress" -Status "User $i of $($Groups.Count) complete" -PercentComplete (($i / $Groups.Count) * 100);
	ForEach-Object {
		try{
			$Record."Status" = Get-ADUser -Identity "$Group" | Select-Object -Property enabled 
			$Record."UserName" = $Group
			$objRecord = New-Object PSObject -property $Record
			$Table += $objrecord
			}
		catch{
			Write-Verbose "An Error has occured"
			Write-Host $_
		}
		$i += 1
	}
}

$Table | Export-csv " " -NoTypeInformation # loaction

Write-Host 'You have successfully exported your file'
echo "`n"
