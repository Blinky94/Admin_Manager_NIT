#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les Owners d'un Groupe Distribution en paramètre
#Group Type                         Value
#Global distribution group          2
#Domain local distribution group    4
#Universal distribution group       8
#Global security group              -2147483646
#Domain local security group        -2147483644
#Universal security group           -2147483640
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 #Final file with Owners list
 $outputowner = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputowner.txt"
 #Temporary files to take groups eventually, and treat them after
 $tmp_CoManagedOwners = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "tmp_CoManagedOwners.txt"
 $tmp_ManagedByOwners = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "tmp_ManagedByOwners.txt"
 $traceLog = "C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE RECHERCHE DE LISTAGE DES MEMBRES D'UN GROUPE DE SECURITE
#--------------------------------------------------------------------------
Function Get_Members_From_SecurityGroup() 
{
	$Category = "Security"
	$OU = "OU=Microsoft Exchange Security Groups,DC=Neuronesit,DC=priv"
	
	$outPutGroup = Get-ADGroup -Filter { (groupCategory -eq $Category) -and (Name -like $line)} `
	-SearchBase $OU `
	| Select name

	$rtn = (Get-ADGroupMember -Identity "$($outPutGroup.name)" -Recursive | get-aduser | where {$_.enabled -like "True" } )

	foreach($Item in $rtn)
	{	
		if($Item.name -ne $KeyWordsForSearch){$Item.name | out-file -append $outputowner}	
	}			
}
#--------------------------------------------------------------------------
#FONCTION DE RECHERCHE DE LISTAGE DES MEMBRES D'UN GROUPE DE DISTRIBUTION
#--------------------------------------------------------------------------
Function Get_Members_From_DistributionGroup()
{
	$Category = "Distribution"
	$OU = "OU=Messagerie,DC=Neuronesit,DC=priv"
	
	$outPutGroup = Get-ADGroup -Filter { (groupCategory -eq $Category) -and (Name -like $line)} `
	-SearchBase $OU `
	| Select name

	$rtn = (Get-ADGroupMember -Identity "$($outPutGroup.name)" -Recursive | get-aduser | where {$_.enabled -like "True" } )

	foreach($Item in $rtn)
	{	
		if($Item.name -ne $KeyWordsForSearch){$Item.name | out-file -append $outputowner}	
	}			
}
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Owners}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Owners
{		
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation des owners d'une DL... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getOwners.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog		
	
		Clear-Content $outputowner
		Clear-Content $tmp_ManagedByOwners
		Clear-Content $tmp_CoManagedOwners

		$KeyWordsForSearch = "*$KeyWordsForSearch*"
		
		$outPut = get-adgroup -SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
		-Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
		-property ManagedBy, MsExchCoManagedByLink `
		| select ManagedBy,MsExchCoManagedByLink
		
		foreach($Item in $outPut)
		{	
			$Item.ManagedBy -replace ',',"`r`n" | Out-File $tmp_ManagedByOwners		
		}

		$output2 = select-string $tmp_ManagedByOwners -pattern "CN=" | foreach {($_.Line)}	
		$output2 = $output2 -split "CN=" | ? {$_.trim() -ne "" } | out-file $tmp_ManagedByOwners			
		
		foreach($line in Get-Content $tmp_ManagedByOwners)
		{
			$outPutUser = get-aduser -SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
			-Filter {(Name -like $line) } -properties * | where {$_.enabled -like "True" }
			
			
			if(!$outPutUser)
			{				
				#Get the GroupType
				$typeGroup = Get-ADGroup -Filter {Name -like $line} `
				-SearchBase "DC=Neuronesit,DC=priv" `
				-Properties GroupType `
				|Select GroupType											
				
				$KeyWordsForSearch = $line
				
				if($typeGroup.GroupType -eq "2"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "4"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "8"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "-2147483646"){Get_Members_From_SecurityGroup}
				elseif($typeGroup.GroupType -eq "-2147483644"){Get_Members_From_SecurityGroup}
				elseif($typeGroup.GroupType -eq "-2147483640"){Get_Members_From_SecurityGroup}	
			}
			
			if($line -ne $KeyWordsForSearch){$line | out-file -append $outputowner}				
		}
		
		foreach($Item in $outPut)
		{	
			$Item.MsExchCoManagedByLink -replace ',',"`r`n" | Out-File $tmp_CoManagedOwners		
		}
		$output2 = select-string $tmp_CoManagedOwners -pattern "CN=" | foreach {($_.Line)}	
		$output2 = $output2 -split "CN=" | ? {$_.trim() -ne "" } | Sort-Object $_ | out-file $tmp_CoManagedOwners	

		foreach($line2 in Get-Content $tmp_CoManagedOwners)
		{
			$outPutUser = get-aduser -SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
			-Filter {(Name -like $line2)} -properties * | where {$_.enabled -like "True" } `
			
			
					
			if(!$outPutUser)
			{				
				#Get the GroupType
				$typeGroup = Get-ADGroup -Filter {Name -like $line2} `
				-SearchBase "DC=Neuronesit,DC=priv" `
				-Properties GroupType `
				|Select GroupType
				
				$KeyWordsForSearch = $line2
				
				if($typeGroup.GroupType -eq "2"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "4"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "8"){Get_Members_From_DistributionGroup}
				elseif($typeGroup.GroupType -eq "-2147483646"){Get_Members_From_SecurityGroup}
				elseif($typeGroup.GroupType -eq "-2147483644"){Get_Members_From_SecurityGroup}
				elseif($typeGroup.GroupType -eq "-2147483640"){Get_Members_From_SecurityGroup}	
			}

			if($line2 -ne $KeyWordsForSearch){$line2 | out-file -append $outputowner}	
		}	
	}		
	Catch{
		$E = $_.Exception
		$ErrorMessage = $E.Message
		$FailedItem = $E.GetType().FullName
		$line = $_.InvocationInfo.ScriptLineNumber
		
		"`r Error type :  $FailedItem `r Error Message :  $ErrorMessage `r line n° : $line" | out-File -Append $traceLog
		Break
	}	
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
Start-Commands
"`r The request has been executed properly !" | Out-File -Append $traceLog	