#Frédéric CAZE-SULFOURT
#Novembre 2016
#Neurones IT
#Programme Powershell pour automatiser la création (activation) des comptes Exchange 2010 des utilisateurs
#à partir d'un fichier .csv précisé en paramètre et de comptes existants dans l'AD de l'OU MAF
#A exécuter via la console EMS Exchange
#----------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#----------------------------------------------------------
#Import-module activedirectory
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
. $env:ExchangeInstallPath\bin\RemoteExchange.ps1
Connect-ExchangeServer -auto

#----------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#----------------------------------------------------------
$FileName 			= $args[0]
$CustomAttribute15 	= "LDSU-DirSync"

Function Start-Commands{Create-MailBox}
#----------------------------------------------------------
#FONCTION DE CREATION DES MAILS BOX
#----------------------------------------------------------
Function Create-MailBox
{
	$FileName = ".\" + $FileName
	$Users = Import-Csv -Path $FileName -Delimiter ";"

	ForEach ($User in $Users) 
	{		
		if($User.EmailAddress -ne "")
		{
			$SamAccountName  = $User.SamAccountName				
			Enable-Mailbox -Identity $SamAccountName -Alias $SamAccountName -Database "EU-MDB-03-001"			
			Set-Mailbox -Identity $SamAccountName -CustomAttribute15 "LDSU-DirSync"		
		}		
	}		
}	

#----------------------------------------------------------
#PROGRAMME PRINCIPAL
#----------------------------------------------------------
Clear
Write-Host "DEBUT DE CREATION DES BOITES MAILS `r`n"
Start-Commands
Write-Host "FIN DE CREATION DES BOITES MAILS"