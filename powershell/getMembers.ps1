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
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\powershell\tmp\" + "outputmember.txt"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{List_Members}
#--------------------------------------------------------------------------
#FONCTION DE LISTAGE DES OWNERS D'UNE LISTE DE DIFFUSION DE L'ACTIVE DIRECTORY
#--------------------------------------------------------------------------
Function List_Members
{	
	Clear-Content $Sortie
	
	$KeyWordsForSearch = "*$KeyWordsForSearch*"
	
	$Groups = Get-ADGroup -Filter {(GroupCategory -eq "Distribution")-and (Name -like $KeyWordsForSearch)} `
	-SearchBase "OU=GroupesDistributions,OU=Messagerie,DC=Neuronesit,DC=priv" `
	-property members `
	| Select members

	#$recipients = $Groups.members -split "CN="

	#ForEach ($g in $recipients) 
	#{
		#if($g -ne "")
		#{
		#	$g.split(',')[0] | out-File -append $Sortie
		#}
	#}
	
	foreach($Item in $Groups)
	{	
		$Item.members -replace ',',"`r`n" | Out-File $Sortie		
	}
	$output = select-string $Sortie -pattern "CN=" | foreach {($_.Line)}	
	$output = $output -split "CN=" | ? {$_.trim() -ne "" } | Sort-Object $_ | out-file $Sortie	
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands