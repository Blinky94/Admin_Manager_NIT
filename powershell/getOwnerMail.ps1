#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour récupérer l'adresse mail d'un utilisateur de l'AD
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $DefaultMail = "NITSupport@neurones.net"
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "getOwnerMail.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_Mail}
#--------------------------------------------------------------------------
#FONCTION DE RECUPERATION DES MAILS DES OWNERS D'UNE LISTE EN PARAMETRE
#--------------------------------------------------------------------------
Function Get_Mail
{			
	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	$outPut = get-aduser -Filter {(Name -like $KeyWordsForSearch)} `
	-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
	-properties mail `
	| select -ExpandProperty mail

	if($outPut -eq $null)
	{
		$outPut = $DefaultMail
	}
	write-host $outPut
	$output | out-file -append $Sortie		
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands