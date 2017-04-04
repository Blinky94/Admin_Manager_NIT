#Frédéric CAZE-SULFOURT
#Avril 2017
#Neurones IT
#Programme Powershell pour vider le contenu d'un fichier passé en paramètre
#--------------------------------------------------------------------------
#VARIABLES
#--------------------------------------------------------------------------
 $FileName = $args[0]
#--------------------------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#--------------------------------------------------------------------------
Function Start-Commands{Clean_File}
#--------------------------------------------------------------------------
#FONCTION DE VIDAGE D4UN FICHIERS
#--------------------------------------------------------------------------
Function Clean_File{Clear-Content $FileName}
#--------------------------------------------------------------------------
#PROGRAMME PRINCIPAL
#--------------------------------------------------------------------------
clear
Start-Commands