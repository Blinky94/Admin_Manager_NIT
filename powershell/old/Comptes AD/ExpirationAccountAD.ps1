#Frédéric CAZE-SULFOURT
#Novembre 2016
#Neurones IT
#Programme Powershell pour lister les anomalies de type {Initials, Surname, GivenName} manquants dans l'OU concernée
#et sortie dans un fichier TXT
#----------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#----------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#----------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#----------------------------------------------------------
Function Start-Commands{ExpirationAccountAD}
#----------------------------------------------------------
#FONCTION DE CORRECTION DES NOMS UTILISATEURS
#----------------------------------------------------------
Function ExpirationAccountAD
{	

	$Sortie = ".\" + "AccountExpirated.csv"
		
	$users = Get-ADUser -Filter 'enabled -eq $True' -SearchBase 'OU=Accounts,OU=Users,OU=FR Maisons Alfort Industrial,DC=pharma,DC=aventis,DC=com' -Properties AccountExpirationDate,DisplayName   | `
Where-Object{$_.AccountExpirationDate -lt (Get-Date) -and $_.AccountExpirationDate -ne $null} | select-object GivenName, SamAccountName, AccountExpirationDate,DisplayName | select DisplayName, SamAccountName,AccountExpirationDate | Export-Csv $Sortie
		
}


#----------------------------------------------------------
#PROGRAMME PRINCIPAL
#----------------------------------------------------------
Clear
Write-Host "DEBUT DE LISTAGE DES COMPTES EXPIRES `r`n"
Start-Commands
Write-Host "FIN DE DE LISTAGE DES COMPTES EXPIRES "
	