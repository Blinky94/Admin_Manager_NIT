#Frédéric CAZE-SULFOURT
#Avril 2017
#Neurones IT
#Programme Powershell pour recuperer les details d'un utilisateur donne passe en parametre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $allArgs = $PsBoundParameters.Values + $args
 $SortieCSV = "C:\NAM\tmp\" + "outPutUserDetails.csv"
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_User_Details}
#--------------------------------------------------------------------------
#FONCTION DE RECUPERATION DES DETAILS SUR UN USER DE L'AD PASSE EN PARAMETRE
#--------------------------------------------------------------------------
Function Get_User_Details
{			
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation de toutes les informations d'un user de l'AD... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getUserDetails.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog		
	
		Clear-content $SortieCSV
		
		$allArgs = "*$allArgs*"
			
		$outPutUser = get-aduser -Filter {(Name -like $allArgs)} `
		-SearchBase "DC=Neuronesit,DC=priv" `
		-properties OfficePhone,Mail,GivenName,Surname,Title  `
		| select OfficePhone,Mail,GivenName,Surname,Title 
					
		foreach($item in $outPutUser)
		{		
			if($item.GivenName -eq $null){$item.GivenName = "N/A"}
			if($item.Surname -eq $null){$item.Surname = "N/A"}
			if($item.Title -eq $null){$item.Title = "N/A"}		
			if($item.OfficePhone -eq $null){$item.OfficePhone = "N/A"}
			if($item.Mail -eq $null){$item.Mail = "N/A"}
			
			$item |  Export-Csv -Path $SortieCSV -Delimiter ";" -NoTypeInformation -Encoding UTF8	
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