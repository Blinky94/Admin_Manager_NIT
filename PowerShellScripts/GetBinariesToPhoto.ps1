#Frédéric CAZE-SULFOURT
#Avril 2017
#Neurones IT
#Programme Powershell pour récupérer la photo codée en binaire dans l'AD
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $User = $args[0]
 $Sortie = "C:\NAM\Images\" + $User + ".jpg"
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_Photo}
#--------------------------------------------------------------------------
#FONCTION DE TRANSFORMATION D'UN BINARY EN JPG
#--------------------------------------------------------------------------
Function Get_Photo
{			
	Try{	
	
		"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
		"`r Script de recuperation d'une photo binaire dans l'AD... Traçage des log du script "  | Out-File -Append $traceLog
		"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
		$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
		$FormattedDate | Out-File -Append $traceLog
		"`r script Name : GetBinariesToPhoto.ps1" | Out-File -Append $traceLog
		"`r parametre : " + $User + "`r" | Out-File -Append $traceLog
		
		$User = "*$User*"
		
		Get-aduser -Filter {(Name -like $User)} `
		-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
		-Properties thumbnailPhoto | Select-Object -ExpandProperty thumbnailphoto | Set-Content -Path $Sortie -Encoding Byte			
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