#FrÃ©dÃ©ric CAZE-SULFOURT
#Avril 2017
#Neurones IT
#Programme Powershell pour recuperer les details d'un utilisateur donné passé en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $User = $args[0]
 $DefaultMail = "None"
 $DefaultPhone = "None"
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outPutUserDetails.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_User_Details}
#--------------------------------------------------------------------------
#FONCTION DE RECUPERATION DES DETAILS SUR UN USER DE L'AD PASSE EN PARAMETRE
#--------------------------------------------------------------------------
Function Get_User_Details
{			
	Clear-content $Sortie
	
	$User = "*$User*"
	
	$outPut = get-aduser -Filter {(Name -like $User)} `
	-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
	-properties OfficePhone,UserPrincipalName,GivenName,Surname,Title  `
	| select OfficePhone,UserPrincipalName,GivenName,Surname,Title 

	foreach($item in $outPut)
	{	
		if($item.GivenName -eq $null)
		{
			$item.GivenName = "N/A"
		}
		
		if($item.Surname -eq $null)
		{
			$item.Surname = "N/A"
		}
		
		if($item.OfficePhone -eq $null)
		{
			$item.OfficePhone = "N/A"
		}
		
		if($item.UserPrincipalName -eq $null)
		{
			$item.UserPrincipalName = "N/A"
		}
		
		if($item.Title -eq $null)
		{
			$item.Title = "N/A"
		}		
				
		$item.GivenName|out-file -append $Sortie 
		$item.Surname|out-file -append $Sortie 
		$item.Title|out-file -append $Sortie 
		$item.OfficePhone|out-file -append $Sortie 
		$item.UserPrincipalName|out-file -append $Sortie 	
	}
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands