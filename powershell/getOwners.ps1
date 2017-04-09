#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les Owners d'un Groupe Distribution en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputowner.txt"
 $tmp = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "tmp.txt"
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

	$rtn = (Get-ADGroupMember -Identity "$($outPutGroup.name)" -Recursive)

	foreach($Item in $rtn)
	{	
		$Item.name | Out-File -append $Sortie		
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

	$rtn = (Get-ADGroupMember -Identity "$($outPutGroup.name)" -Recursive)

	foreach($Item in $rtn)
	{	
		$Item.name | Out-File -append $Sortie		
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
	Clear-Content $Sortie
	Clear-Content $tmp	

	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	$outPut = get-adgroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
	-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
	-property ManagedBy, MsExchCoManagedByLink `
	| select ManagedBy,MsExchCoManagedByLink
	
	foreach($Item in $outPut)
	{	
		$Item.ManagedBy -replace ',',"`r`n" | Out-File $Sortie		
	}
	$output2 = select-string $Sortie -pattern "CN=" | foreach {($_.Line)}	
	$output2 = $output2 -split "CN=" | ? {$_.trim() -ne "" } | out-file $Sortie		
	
	foreach($Item in $outPut)
	{	
		$Item.MsExchCoManagedByLink -replace ',',"`r`n" | Out-File $tmp		
	}
	$output2 = select-string $tmp -pattern "CN=" | foreach {($_.Line)}	
	$output2 = $output2 -split "CN=" | ? {$_.trim() -ne "" } | Sort-Object $_ | out-file -append $Sortie		
	
	foreach($line in Get-Content $Sortie)
	{
		$outPutUser = get-aduser -Filter {(Name -like $line)} `
		-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
		-properties OfficePhone,UserPrincipalName,GivenName,Surname,Title  `
		| select OfficePhone,UserPrincipalName,GivenName,Surname,Title 		
		
		if($outPutUser -eq $null)
		{		
			write-host "pas d'user c'est un groupe !"		
			#Get-Content $Sortie | Where-Object {$_ -notmatch $line} | Set-Content $Sortie
			
			#Get the GroupType
			$typeGroup = Get-ADGroup -Filter {Name -like $line} `
			-SearchBase "DC=Neuronesit,DC=priv" `
			-Properties GroupType `
			|Select GroupType
					
			#Group Type                         Value
			#Global distribution group          2
			#Domain local distribution group    4
			#Universal distribution group       8
			#Global security group              -2147483646
			#Domain local security group        -2147483644
			#Universal security group           -2147483640
			
			if($typeGroup.GroupType -eq "2"){Get_Members_From_DistributionGroup}
			elseif($typeGroup.GroupType -eq "4"){Get_Members_From_DistributionGroup}
			elseif($typeGroup.GroupType -eq "8"){Get_Members_From_DistributionGroup}
			elseif($typeGroup.GroupType -eq "-2147483646"){Get_Members_From_SecurityGroup}
			elseif($typeGroup.GroupType -eq "-2147483644"){Get_Members_From_SecurityGroup}
			elseif($typeGroup.GroupType -eq "-2147483640"){Get_Members_From_SecurityGroup}	
		}
	}
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands