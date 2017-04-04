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
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands