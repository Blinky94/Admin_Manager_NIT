#Frédéric CAZE-SULFOURT
#Octobre 2016
#Neurones IT
#Programme Powershell pour automatiser la création de comptes utilisateurs sur l'Active Directory
#à partir d'un fichier .csv passé en paramètre.

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
Function Start-Commands{Create-Users}

$FileName = $args[0]
#----------------------------------------------------------
#FONCTION DE CREATION DES COMPTES UTILISATEURS
#----------------------------------------------------------
Function Create-Users
{
	$Sortie = ".\" + "Sortie.txt"
	Remove-Item $Sortie		
	$FileName = ".\" + $FileName
	Get-Content -Path $FileName | Out-File -FilePath ".\tempFileUnicode.csv" -Encoding Unicode
	$Users = Import-Csv -Path ".\tempFileUnicode.csv" -Delimiter ";" -Encoding Unicode

	ForEach ($User in $Users) 
	{		
		#Variables statiques
		$GivenName 				= Remove-Diacritics $User.GivenName.ToLower()
		$GivenName = $GivenName.substring(0,1).ToUpper() + $GivenName.substring(1).ToLower()
		$Surname 				= Remove-Diacritics $User.Surname.ToLower()
		$Surname = $Surname.substring(0,1).ToUpper() + $Surname.substring(1).ToLower()
		$Company				= Remove-Diacritics $User.Company
		$Departement			= Remove-Diacritics $User.Department		
		#Determine si le DisplayName est de la forme /PH/FR (interne, CDD, CDI,Alternant) ou /PH/FR/EXT (Interim,prestataire)
		if($User.Interim -eq $true -Or $User.Company -ne "sanofi".ToLower()){$DisplayName = $Surname + ", " + $GivenName + " PH/FR/EXT"}
		elseif ($User.Interim -eq $false -Or $User.Company -eq "Sanofi".ToLower()){$DisplayName		= $Surname + ", " + $GivenName + " PH/FR"}	
		#$DisplayName			= Remove-Diacritics $User.DisplayName				
		$EmailAddress			= $User.EmailAddress
		$dnsroot    	        = "@pharma.aventis.com"
		$StreetAddress          = "180, Rue Jean Jaures"
		$BP    		            = "BP 40"
		$City  		            = "Maisons-Alfort"
		$State 		            = "Ile de France"
		$PostalCode	 	        = "94702 Cedex"
		$OfficePhone            = "+33 14518"
		$Country   		        = "FR"
		$Description 	        = "CREATION Via Ticket - ID "
		$ScriptPath 	        = "APH\logonscriptia.vbe MAF.ini"
		$Department 	        = ""
		$pwd        	        = ConvertTo-SecureString "Sanofi01" -AsPlainText -force
		$enabled   		        = $True
		$PasswordNeverExpires   = $false
		$ChangePasswordAtLogon  = $true
		if($User.AccountExpirationDate -eq '0'){$AccountExpirationDate  = $null }
		else { $AccountExpirationDate  = ([DateTime]($User.AccountExpirationDate)).AddDays(1)}

		#Creation du nouvel utilisateur
		New-ADUser -Name $DisplayName `
		-GivenName $GivenName `
		-Surname $Surname `
		-ScriptPath $ScriptPath `
		-POBox $BP `
		-State $State `
		-StreetAddress $StreetAddress `
		-City $City `
		-Company $Company `
		-Country $Country `
		-Department ($Department + " " + $Departement) `
		-Description ($Description + $User.Description) `
		-DisplayName $DisplayName `
		-EmailAddress $EmailAddress.ToLower() `
		-Enabled $enabled `
		-Initials $User.Initials `
		-OfficePhone ($OfficePhone + " " + $User.OfficePhone) `
		-PostalCode $PostalCode `
		-Path $User.Path `
		-UserPrincipalName ($User.SamAccountName + $dnsroot) `
		-AccountExpirationDate  $AccountExpirationDate `
		-AccountPassword $pwd -PassThru `
		-ChangePasswordAtLogon $ChangePasswordAtLogon `
		-PasswordNeverExpires $PasswordNeverExpires `
		-SamAccountName $User.SamAccountName 
		
		#Groupes universels obligatoires pour chaque nouveaux comptes utilisateurs
		Add-ADGroupMember -Identity "CN=Maisons-Alfort All Users,OU=Distribution Lists,OU=FR Maisons Alfort Industrial,DC=pharma,DC=aventis,DC=com" -Members $User.SamAccountName 
		Add-ADGroupMember -Identity "CN=MAF NT-Users,OU=Groups,OU=Users,OU=FR Maisons Alfort Industrial,DC=pharma,DC=aventis,DC=com" -Members $User.SamAccountName
		#Groupe global MAF_Partage_Communication
		$grp = "MAF_Partage_Communication"
		$grpDN = (get-adgroup $grp).distinguishedname
		Add-ADGroupMember -Identity $grpDN -Members $User.SamAccountName

		$SamAccountName = $User.SamAccountName
		#Si le nouvel utilisateur est interimaire
		if ($User.Interim -eq $false)
		{
			#pharma.aventis.com/FR Maisons Alfort Industrial/Distribution Lists/MAF Salariés (universel)
			#Add-ADGroupMember -Identity "MAF Salariés" -Members $User.SamAccountName 
			Add-ADGroupMember -Identity "CN=MAF Salaries,OU=Distribution Lists,OU=FR Maisons Alfort Industrial,DC=pharma,DC=aventis,DC=com" -Members $User.SamAccountName 
		}
				
		#Si le nouvel utilisateur est un encadrant
		if ($User.Cadre -eq $true)
		{
			#pharma.aventis.com/FR Maisons Alfort Industrial/Distribution Lists/MAF Cadres et Personnel Encadrant
			Add-ADGroupMember -Identity "CN=MAF Cadres et Personnel Encadrant,OU=Distribution Lists,OU=FR Maisons Alfort Industrial,DC=pharma,DC=aventis,DC=com" -Members $User.SamAccountName 
			
			#pharma.aventis.com/FR Maisons Alfort Industrial/Users/Groups/MAF_CADRES_ET_PERSONNELS_ENCADRANTS (global)
			$grp2 = "MAF_CADRES_ET_PERSONNELS_ENCADRANTS"
			$grpDN2 = (get-adgroup $grp2).distinguishedname
			Add-ADGroupMember -Identity $grpDN2 -Members $User.SamAccountName
		}
				
		#Si le nouvel utilisateur a les droits Internet
		if ($User.Internet -eq $true)
		{
			#pharma.aventis.com/FR Maisons Alfort Industrial/Administration/Admin Groups/MAF Internet Access (global)
			$grp3 = "MAF Internet Access"
			$grpDN3 = (get-adgroup $grp3).distinguishedname
			Add-ADGroupMember -Identity $grpDN3 -Members $User.SamAccountName
		}	
		
		if ($User.RepPerso -eq $true)
		{
			#pharma.aventis.com/FR Maisons Alfort Industrial/Users/Groups/MAF_STDUsers_Partage (global)
			$grp4 = "MAF_STDUsers_Partage"
			$grpDN4 = (get-adgroup $grp4).distinguishedname
			Add-ADGroupMember -Identity $grpDN4 -Members $User.SamAccountName
		}		
	
		if($User.RepPerso -eq $true){$IsRepPerso = "OUI"}else{$IsRepPerso = "NON"}
		if($User.Internet -eq $true){$IsInternet = "OUI"}else{$IsInternet = "NON"}
		
		$IsMail = $User.EmailAddress

		if([bool]$IsMail){$IsMail = "OUI"}
		if(![bool]$IsMail){$IsMail = "NON"}	
		
		$text = 
		"Bonjour,
		
		Votre demande de creation d'un nouveau compte Windows a bien ete traitee. Les informations pour la 1ere connexion sont : `
`
		- Display Name : $DisplayName `
		- Login : $SamAccountName `
`
		Option(s) : `
		Mails : $IsMail `
		Dossier Personnel : $IsRepPerso `
		Internet : $IsInternet `
`
		L'utilisateur sera invite a changer son mot de passe lors de sa premiere connexion. `
		Nous vous rappelons que la signature de la charte Informatique est obligatoire pour la remise des acces a l'utilisateur. (Contrat-Clic)`
		Merci d'inviter l'utilisateur a s'enroler sur SafeCom ou l'accompagner si necessaire."

		#Sortie des créations de compte vers un fichier texte temporaire pour permettre la recopie des info dans GLPI
		$text >> $Sortie
	}	
}

#----------------------------------------------------------
#PROGRAMME PRINCIPAL
#----------------------------------------------------------
Clear
Write-Host "DEBUT DE CREATION DES COMPTES AD `r`n"
Start-Commands
Write-Host "FIN DE CREATION DES COMPTES AD"