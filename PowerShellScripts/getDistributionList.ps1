#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister le contenu de l'OU Groupes Distributions
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
$KeyWordsForSearch = $args[0]
$Sortie = "C:\NAM\tmp\" + "outputDistribution.txt"
$traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Distribution}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES LISTES DE DISTRIBUTION DANS L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Distribution
{		
	Try{
	
		"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
		"`r Script de recuperation des Listes de Distribution dans une OU determinee avec argument... Traçage des log du script "  | Out-File -Append $traceLog
		"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
		$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
		$FormattedDate | Out-File -Append $traceLog
		"`r script Name : getDistributionList.ps1" | Out-File -Append $traceLog
		"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog
		
		Clear-Content $Sortie

		$KeyWordsForSearch = "*$KeyWordsForSearch*"

		Get-ADGroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
		-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
		| sort name `
		| select Name -expandproperty name `
		| Out-File $Sortie	
		
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