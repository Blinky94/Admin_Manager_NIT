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
 $allArgs = $PsBoundParameters.Values + $args
 $SortieCSV = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outPutUserDetails.csv"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_User_Details}
#--------------------------------------------------------------------------
#FONCTION DE RECUPERATION DES DETAILS SUR UN USER DE L'AD PASSE EN PARAMETRE
#--------------------------------------------------------------------------
Function Get_User_Details
{			
	Clear-content $SortieCSV
	
	$allArgs = "*$allArgs*"
		
	$outPutUser = get-aduser -Filter {(Name -like $allArgs)} `
	-SearchBase "DC=Neuronesit,DC=priv" `
	-properties OfficePhone,Mail,GivenName,Surname,Title  `
	| select OfficePhone,Mail,GivenName,Surname,Title 
				
	foreach($item in $outPutUser)
	{		
		if($item.GivenName -eq $null){$item.GivenName = "N/A"}
		if($item.Surname -eq $null){$item.Surname = "N/A"}
		if($item.Title -eq $null){$item.Title = "N/A"}		
		if($item.OfficePhone -eq $null){$item.OfficePhone = "N/A"}
		if($item.Mail -eq $null){$item.Mail = "N/A"}
		
		$item |  Export-Csv -Path $SortieCSV -Delimiter ";" -NoTypeInformation -Encoding UTF8	
	}		
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands