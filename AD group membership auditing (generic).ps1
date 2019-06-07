Import-Module activedirectory

$ADgrp = Read-Host -Prompt 'Input AD group'

$Groups = (Get-Adgroup -filter * | Where {$_.name -like "*$ADgrp*"} | select name -expandproperty name)

$Table = @()

$Record = @{
"Group Name" = ""
"Name" = ""
"Username" = ""
}

Foreach($Group in $Groups)
{	
	
	$Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | select name,samaccountname
	foreach ($Member in $Arrayofmembers){
		$percent = $ArrayofMembers.indexOf($Member) / $Arrayofmembers.length * 100
		Write-Progress -Activity "Processing users" -Status "$percent% Complete" -PercentComplete $percent
		try{
			$Record."Group Name" = $Group
			$Record."Name" = $Member.name
			$Record."UserName" = $Member.samaccountname
			$objRecord = New-Object PSObject -property $Record
			$Table += $objrecord				
			}
			
		catch{
			Write-Verbose "An error has occured"
			Write-Host $_
		}
	}
}
break


$Table | Export-csv "\$ADgrp.csv" -NoTypeInformation

Write-Host 'You have successfully exported your file'
echo "`n"