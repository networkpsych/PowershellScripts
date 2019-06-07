Import-Module activedirectory

$Groups = Read-Host -Prompt 'AD group'

$ADremover = Get-Content " "

$Table = @Table()

@Record = @{
	"User" = ""
	"Group removed" = ""
}

ForEach ($Group in $Groups){
	for ($i = 1; $i -le 100; $i++ )
	{
		Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i;
		ForEach-Object{
			try{ # Creates table for Ticket records
				Remove-ADGroupMember -Identity"$Group" -members $_.users
				$Record."User" = $Group.users
				$Record."Group removed" = $Group
				$objRecord = New-Object PSObject -Property $Record
				$Table += $Record
				}
			catch [Microsoft.ActiveDirectory.Management.AdGroupNotFoundException] { # In case a person mispells the AD group
				Write-Verbose "Check if AD group exists" 
				Write-Host $_
			}
			catch{
				Write-Verbose "An error has occured"
				Write-Host $_
			}
		}
	}	
}

$Table | Export-csv " \$Group.csv" -NotypeInformation

Write-Host "Users removed successfully"

echo "`n"


