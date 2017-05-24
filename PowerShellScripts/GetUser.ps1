#Frédéric CAZE-SULFOURT
#Mai 2017
#Neurones IT
#Programme Powershell pour rechercher un utilisateur avec un nom passé en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
$KeyWordsForSearch = $args[0]
$Sortie = "C:\NAM\tmp\" + "GetUser.txt"
$traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Search_User}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES UTILISATEURS DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function Search_User
{		
	Try{	
	
		"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
		"`r Script de recherche de members dans une DL en execution... Traçage des log du script "  | Out-File -Append $traceLog
		"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
		$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
		$FormattedDate | Out-File -Append $traceLog
		"`r script Name : GetUser.ps1" | Out-File -Append $traceLog
		"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog
		
		Clear-Content $Sortie
		
		if($KeyWordsForSearch -ne "*"){$KeyWordsForSearch = "*$KeyWordsForSearch*"}	
		
		get-aduser -SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
			-Filter {(Name -like $KeyWordsForSearch)} -properties * | where {$_.enabled -like "True" } `
			|select -ExpandProperty Name | out-file $Sortie
			
			"`r The request has been executed properly !" | Out-File -Append $traceLog				 
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