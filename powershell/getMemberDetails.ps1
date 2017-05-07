#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les details d'un Member d'une liste de distribution en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "memberDetails.txt"
 $traceLog = "C:\Users\FCazesulfourt\Desktop\Export_CSV_Entretiens_Professionnels\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Member_Details}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES DETAILS D'UN MEMBER DONNE DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function Member_Details
{	
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation des details d'un membre d'une DL... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getMemberDetails.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog
		
		Clear-Content $Sortie
		
		$KeyWordsForSearch = "*$KeyWordsForSearch*"
		
		Get-AdUser -Filter {(name -Like $KeyWordsForSearch)} `
		-Properties SurName, GivenName,Title,Mail,Telephonenumber `
		| Select SurName, GivenName,Title,Mail,Telephonenumber `
		| ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Set-Content $Sortie -Encoding "UTF8"
		
		$output = (Get-Content $Sortie) -split ',' 
		(Get-Content $Sortie) | Foreach-Object {$output -replace  '"', ""} | Set-Content $Sortie
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