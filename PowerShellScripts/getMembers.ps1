#Frédéric CAZE-SULFOURT
#Mars 2017
#Neurones IT
#Programme Powershell pour lister les Members d'un Groupe Distribution en paramètre
#--------------------------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#--------------------------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $KeyWordsForSearch = $args[0]
 $Sortie = "C:\NAM\tmp\" + "outputmember.txt"
 $traceLog = "C:\NAM\logs\LogPowershell_ScritpOutput.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Members}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Members
{	
	Try{						
			"`r ---------------------------------------------------------"  | Out-File -Append $traceLog
			"`r Script de recuperation des details d'un membre d'une DL... Traçage des log du script "  | Out-File -Append $traceLog
			"`r --------------------------------------------------------- "  | Out-File -Append $traceLog
			$FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss `r ---------------------------------------------------------" 
			$FormattedDate | Out-File -Append $traceLog
			"`r script Name : getMembers.ps1" | Out-File -Append $traceLog
			"`r parametre : " + $KeyWordsForSearch + "`r" | Out-File -Append $traceLog
	
		Clear-Content $Sortie
		
		$KeyWordsForSearch = "$KeyWordsForSearch"
		
		$Groups = Get-ADGroupMember -Identity $KeyWordsForSearch | get-aduser | where {$_.enabled -like "True" } | select-object distinguishedName
				
		foreach($Item in $Groups)
		{	
			$Item.distinguishedName -replace ',',"`r`n" | Out-File -append $Sortie		
		}
		
		$output = select-string $Sortie -pattern "CN=" | foreach {($_.Line)}	
		$output = $output -split "CN=" | ? {$_.trim() -ne "" } | Sort-Object $_ | out-file $Sortie	
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