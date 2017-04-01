#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les details d'un Member d'une liste de distribution en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "memberDetails.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Member_Details}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES DETAILS D'UN MEMBER DONNE DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function Member_Details
{	
	Clear-Content $Sortie
	
	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	Get-AdUser -Filter {(name -Like $KeyWordsForSearch)} `
	-Properties SurName, GivenName,Title,Mail,Telephonenumber `
	| Select SurName, GivenName,Title,Mail,Telephonenumber `
	| ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Set-Content $Sortie -Encoding "UTF8"
	
	$output = (Get-Content $Sortie) -split ',' 
    (Get-Content $Sortie) | Foreach-Object {$output -replace  '"', ""} | Set-Content $Sortie
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands