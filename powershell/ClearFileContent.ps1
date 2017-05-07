#Frédéric CAZE-SULFOURT
#Avril 2017
#Neurones IT
#Programme Powershell pour vider le contenu d'un fichier passé en paramètre
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $FileName = $args[0]
 $traceLog = "C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Clean_File}
#--------------------------------------------------------------------------
#FONCTION DE VIDAGE D4UN FICHIERS
#--------------------------------------------------------------------------
Function Clean_File
{
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de nettoyage d'un fichier temporaire... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : ClearFileContent.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $FileName + "`r" | Out-File -Append $traceLog
			
			Clear-Content $FileName
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
clear
Start-Commands
"`r The request has been executed properly !" | Out-File -Append $traceLog	