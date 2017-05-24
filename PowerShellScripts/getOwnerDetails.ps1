#Fr�d�ric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les details d'un Owner en param�tre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\NAM\tmp\" + "outputowner.txt"
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
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
			"`r Script de recuperation des details d'un owner d'une DL... Tra�age des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getOwnerDetails.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog	
	
		Clear-Content $Sortie
		
		$KeyWordsForSearch = "*$KeyWordsForSearch*"
		
		$outPut = get-adgroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
		-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
		-property ManagedBy `
		| select ManagedBy

		foreach($Item in $outPut)
		{	
			$arr = $Item -split ','
			$arr2 = $arr[0] -split '='
			$arr2[2] | Out-File $Sortie
		}
	}
	Catch{
		$E = $_.Exception
		$ErrorMessage = $E.Message
		$FailedItem = $E.GetType().FullName
		$line = $_.InvocationInfo.ScriptLineNumber
		
		"`r Error type :  $FailedItem `r Error Message :  $ErrorMessage `r line n� : $line" | out-File -Append $traceLog
		Break
	}	
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands
"`r The request has been executed properly !" | Out-File -Append $traceLog	