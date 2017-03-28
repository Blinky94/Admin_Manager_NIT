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
$Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputDistribution.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Distribution}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES LISTES DE DISTRIBUTION DANS L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Distribution
{			
	Clear-Content $Sortie

	Get-ADGroup -Filter {(GroupCategory -eq "Distribution")} `
	| sort name `
	| select Name -expandproperty name `
	| format-table -autosize -hidetableheaders `
	| Out-File $Sortie
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
Start-Commands