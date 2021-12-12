Set-PSRepository psgallery -InstallationPolicy trusted
Install-Module -Name Az.Functions -Repository PSGallery -Force
Install-Module -Name Az.Websites -Repository PSGallery -Force
Install-Module -Name Pester -RequiredVersion 5.0.4 -Confirm:$false -Force
Invoke-Pester ./Script.ps1 -EnableExit