#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour récupérer l'adresse mail d'un utilisateur de l'AD
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $DefaultMail = "NITSupport@neurones.net"
 $Sortie = "C:\NAM\tmp\" + "getOwnerMail.txt"
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_Mail}
#--------------------------------------------------------------------------
#FONCTION DE RECUPERATION DES MAILS DES OWNERS D'UNE LISTE EN PARAMETRE
#--------------------------------------------------------------------------
Function Get_Mail
{				
	Try{	
			Clear-Content $Sortie	
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation de mails d'un owner d'une DL... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getOwnerMail.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog	
	
			$KeyWordsForSearch = "*$KeyWordsForSearch*"
			
			$outPut = get-aduser -Filter {(Name -like $KeyWordsForSearch)} `
			-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
			-properties mail `
			| select -ExpandProperty mail

			if($outPut -eq $null)
			{
				$outPut = $DefaultMail
			}
		
			$output | out-file -append $Sortie	
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