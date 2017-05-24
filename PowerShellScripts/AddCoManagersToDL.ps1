#Frédéric CAZE-SULFOURT
#Mai 2017
#Neurones IT
#Programme Powershell pour ajouter un CoManager dans une liste de distribution
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForAdd = $args[0]
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION POUR RECHERCHER LE DISTINGUISHEDNAME D'UN UTILISATEUR
#--------------------------------------------------------------------------
Function GetDistinguishedNameMember($User)
{
	$User = "*$User*"

	$DistinguishedName = get-aduser -SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
		-Filter {(Name -like $User)} -properties * | where {$_.enabled -like "True" } `
		|select DistinguishedName
	
	return "$DistinguishedName"
}
#--------------------------------------------------------------------------
#FONCTION POUR RECHERCHER LE DISTINGUISHEDNAME D'UN GROUPE
#--------------------------------------------------------------------------
Function GetDistinguishedNameGroup($Group)
{
	$Group = "*$Group*"

	$DistinguishedName = get-ADGroup -SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
		-Filter {(Name -like $Group)} -properties * `
		|select DistinguishedName

	return "$DistinguishedName"
}
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Add_CoManager}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function Add_CoManager
{		
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation des owners d'une DL... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getOwners.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForAdd + "`r" | Out-File -Append $traceLog		
	
			if($KeyWordsForAdd -ne "")
			{	
				$User = $KeyWordsForAdd.split('@')[0]
				$DL = $KeyWordsForAdd.split('@')[1]
			}		
			$DL = "*$DL*"
			
			$DistinguishedNameUser = GetDistinguishedNameMember($User)
			$DistinguishedNameUser = "$DistinguishedNameUser".trim("@{DistinguishedName=").split('}')

			$DistinguishedGroup = GetDistinguishedNameGroup($DL)
			$DistinguishedGroup = "$DistinguishedGroup".trim("@{DistinguishedName=").split('}')

	
			
			Set-Adgroup -Identity "$DistinguishedGroup" -Add @{msExchCoManagedByLink="$DistinguishedNameUser"}	
	}			
	Catch{
		$E = $_.Exception
		$ErrorMessage = $E.Message
		$FailedItem = $E.GetType().FullName
		$line = $_.InvocationInfo.ScriptLineNumber
		
		"`r Error type :  $FailedItem `r Error Message :  $ErrorMessage `r line n° : $line" | out-File -Append $traceLog
		Break
	}	
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
Start-Commands
"`r The request has been executed properly !" | Out-File -Append $traceLog	