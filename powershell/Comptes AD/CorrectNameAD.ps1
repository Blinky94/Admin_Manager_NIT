#Frédéric CAZE-SULFOURT
#Novembre 2016
#Neurones IT
#Programme Powershell corriger les majuscules et minuscules dans les noms et prenoms utilisateurs
#----------------------------------------------------------
# MODULE ACTIVE DIRECTORY
#----------------------------------------------------------
 Import-Module ActiveDirectory -ErrorAction Stop
#----------------------------------------------------------
# FONCTION DE SUPPRESSION DES ACCENTUATIONS
#----------------------------------------------------------
Function Remove-Diacritics 
{
  param ([String]$sToModify = [String]::Empty)

  foreach ($s in $sToModify)
  {
    if ($sToModify -eq $null) {return [string]::Empty}

    $sNormalized = $sToModify.Normalize("FormD")

    foreach ($c in [Char[]]$sNormalized)
    {
      $uCategory = [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($c)
      if ($uCategory -ne "NonSpacingMark") {$res += $c}
    }

    return $res
  }
}

#----------------------------------------------------------
#FONCTION DE LANCEMENT DU PROGRAMME
#----------------------------------------------------------
Function Start-Commands{Correct_Users_AD}

$FileName = $args[0]
#----------------------------------------------------------
#FONCTION DE CORRECTION DES NOMS UTILISATEURS
#----------------------------------------------------------
Function Correct_Users_AD
{	
	$FileName = ".\" + $FileName
	Get-Content -Path $FileName | Out-File -FilePath ".\tempFileUnicode.csv" -Encoding Unicode
	$Users = Import-Csv -Path ".\tempFileUnicode.csv" -Delimiter ";" -Encoding Unicode

	#ForEach ($User in $Users) 
	#{		
		#Variables statiques
	#	$GivenName 				= Remove-Diacritics $User.GivenName.ToLower()
	#	$GivenName 				= $GivenName.substring(0,1).ToUpper() + $GivenName.substring(1).ToLower()
	#	$Surname 				= Remove-Diacritics $User.Surname.ToLower()
	#	$Surname 				= $Surname.substring(0,1).ToUpper() + $Surname.substring(1).ToLower()
		
		#Determine si le DisplayName est de la forme /PH/FR (interne, CDD, CDI,Alternant) ou /PH/FR/EXT (Interim,prestataire)
	#	if($User.Interim -eq $true -Or $User.Company -ne "sanofi".ToLower()){$DisplayName = $Surname + ", " + $GivenName + " PH/FR/EXT"}
	#	elseif ($User.Interim -eq $false -Or $User.Company -eq "Sanofi".ToLower()){$DisplayName		= $Surname + ", " + $GivenName + " PH/FR"}	
		
		$users = Get-ADUser -Filter * -SearchBase $User.Path -Properties DisplayName, Initials 
		
		ForEach($user in $users)
		{
			Write-Host $user.DisplayName
		}
	}	
}

#----------------------------------------------------------
#PROGRAMME PRINCIPAL
#----------------------------------------------------------
Clear
Write-Host "DEBUT DE CORRECTION DES COMPTES AD `r`n"
Start-Commands
Write-Host "FIN DE CORRECTION DES COMPTES AD"