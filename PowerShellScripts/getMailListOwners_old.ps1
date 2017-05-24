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
	Clear-Content $Sortie

	$KeyWordsForSearch = "*$KeyWordsForSearch*"

	Get-ADGroup -Filter {(GroupCategory -eq "Distribution") -and (Name -like $KeyWordsForSearch)} `
	| select Name ManagedBy `
	| Sort -Property Name `
	| format-table -autosize -hidetableheaders `
	| Out-File $Sortie
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
Start-Commands