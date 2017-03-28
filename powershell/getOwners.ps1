#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
 $KeyWordsForSearch = $args[0]
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Owners}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Owners
{			
	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	$outPut = get-adgroup -Filter {(GroupCategory -eq "Distribution") } `
	-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
	-property ManagedBy `
	| select ManagedBy

	foreach($Item in $outPut)
	{	
		$arr = $Item -split ','
		$arr2 = $arr[0] -split '='
		write $arr2[2]
	}
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands