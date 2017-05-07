#Frédéric CAZE-SULFOURT
#Mai 2017
#Neurones IT
#Programme Powershell pour ajouter un utilisateur dans une liste de distribution
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
 #Set-PSDebug -Trace 2 
 $traceLog = "C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
$KeyWordsForAdd = $args[0]
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Add_User}
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
#FONCTION DE LISTAGE DES UTILISATEURS DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function Add_User
{		
	Try{
		$KeyWordsForAdd = "$KeyWordsForAdd"
		
		"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
		"`r Script d'ajout de members dans une DL en execution... Traçage des log du script "  | Out-File -Append $traceLog
		"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
		$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
		$FormattedDate | Out-File -Append $traceLog
		"`r script Name : AddUser.ps1" | Out-File -Append $traceLog
		"`r parametre : " + $KeyWordsForAdd + "`r" | Out-File -Append $traceLog
		
		if($KeyWordsForAdd -ne "")
		{	
			$User = $KeyWordsForAdd.split('@')[0]
			$DL = $KeyWordsForAdd.split('@')[1]
			
			#DistringuishedName user
			$DistinguishedNameUser = GetDistinguishedNameMember($User)
			$DistinguishedNameUser = "$DistinguishedNameUser".trim("@{DistinguishedName=").split('}')

			$DL = "*$DL*"
			
			Get-ADGroup -SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
			-Filter { name -like $DL } |
			 Add-ADGroupMember -Members "$DistinguishedNameUser"	

			"`r The user named : " + $User + " has been added to the Distribution List : " +  $DL + " with success !" | Out-File -Append $traceLog				 
		}
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