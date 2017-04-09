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
 $Sortie = "C:\Users\FCazesulfourt\Documents\NIT_2017\Admin_Manager_NIT\Admin Manager NIT\Images\" + $User + ".jpg"
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Get_Photo}
#--------------------------------------------------------------------------
#FONCTION DE TRANSFORMATION D'UN BINARY EN JPG
#--------------------------------------------------------------------------
Function Get_Photo
{			
	$User = "*$User*"
	
	Get-aduser -Filter {(Name -like $User)} `
	-SearchBase "OU=Utilisateurs,DC=Neuronesit,DC=priv" `
	-Properties thumbnailPhoto | Select-Object -ExpandProperty thumbnailphoto | Set-Content -Path $Sortie -Encoding Byte
}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands