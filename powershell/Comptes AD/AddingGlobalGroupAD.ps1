#Frédéric CAZE-SULFOURT
#Novembre 2016
#Neurones IT
#Programme Powershell ajouter une liste d'utilisateurs dans un groupe global Active Directory
#----------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#----------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop

#----------------------------------------------------------
#DESIGNATION DU GROUPE GLOBAL CIBLE
#indiquer dans la variable le groupe global cible
#----------------------------------------------------------
$GroupeGobalCible = "MAF-LUNA-PROD"

#----------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#----------------------------------------------------------
Function Start-Commands{AddUsersInGlobalGroup}

$FileName = $args[0]
#----------------------------------------------------------
#FONCTION DE CORRECTION DES NOMS UTILISATEURS
#----------------------------------------------------------
Function AddUsersInGlobalGroup
{	
	$FileName = ".\" + $FileName
	Get-Content -Path $FileName | Out-File -FilePath ".\tempFileUnicode.csv" -Encoding Unicode
	$Users = Import-Csv -Path ".\tempFileUnicode.csv" -Delimiter ";" -Encoding Unicode
	
	ForEach ($User in $Users) 
	{			
		$grpDN2 = (get-adgroup $GroupeGobalCible).distinguishedname
		Add-ADGroupMember -Identity $grpDN2 -Members $User.SamAccountName
	}			
}

#----------------------------------------------------------
#PROGRAMME PRINCIPAL
#----------------------------------------------------------
Clear
Write-Host "DEBUT D'AJOUT DES UTILISATEURS DANS LE GROUPE GLOBAL `r`n"
Start-Commands
Write-Host "FIN D'AJOUT DES UTILISATEURS DANS LE GROUPE GLOBAL "
	