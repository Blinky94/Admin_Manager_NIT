#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les "owners" contenu dans un groupe de distribution spécifique
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
$KeyWordsForSearch = $args[0]
$Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputowner.txt"
$traceLog = "C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Owners}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Owners
{			
	Try{	
	
		"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
		"`r Script de recuperation des Mails des Owners dans une DL... Traçage des log du script "  | Out-File -Append $traceLog
		"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
		$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
		$FormattedDate | Out-File -Append $traceLog
		"`r script Name : getMailListOwners.ps1" | Out-File -Append $traceLog
		"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog
		
		Clear-Content $Sortie

		$KeyWordsForSearch = "*$KeyWordsForSearch*"

		Get-ADGroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
		-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
		-Properties name,managedby `	 
		| select name,managedby `
		| Sort -Property Name `
		| format-table -autosize -hidetableheaders `
		| Out-File $Sortie			
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

get-adgroup -Filter {(GroupCategory -eq "Distribution")} -SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" -property ManagedBy | %{(($_.ManagedBy -replace "\\,","~").split(",")[0] -replace "~",",").SubString(3)} | select $_.ManagedBy
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
Start-Commands
"`r The request has been executed properly !" | Out-File -Append $traceLog	