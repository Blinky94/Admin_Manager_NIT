#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les details d'un Owner en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputowner.txt"
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
	
	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	$outPut = get-adgroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
	-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
	-property ManagedBy `
	| select ManagedBy

	foreach($Item in $outPut)
	{	
		$arr = $Item -split ','
		$arr2 = $arr[0] -split '='
		$arr2[2] | Out-File $Sortie
	}
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands