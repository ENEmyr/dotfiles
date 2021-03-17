# Call commands at startup
Function VerifyModule() {
	$PoshGit = Get-InstalledModule -Name "posh-git"
	$OhMyPosh = Get-InstalledModule -Name "oh-my-posh"
	$PSReadline = Get-InstalledModule -Name "PSReadline"
	# Check Powershell Edition, Core edition and Desktop edition maybe need to have different modules
	$Edition = $PSVersionTable.PSEdition
	# Check Windows-Screenfetch module (https://github.com/JulianChow94/Windows-screenFetch)
	$WindowsScreenfetch = Find-Module -Name "windows-screenfetch"
		
	if ($PoshGit.Count -eq 0) {
		Install-Module posh-git -Scope CurrentUser -Force
	}
	if ($OhMyPosh.Count -eq 0) {
		Install-Module oh-my-posh -Scope CurrentUser -Force
	}
	if ($WindowsScreenfetch.Count -eq 0) {
		# The error might be occurs when ran on Core edition because the module have legacy code
		# And need to change some of the code from Get-WMIObject to Get-CimInstance to do it work properly
		Install-Module windows-screenfetch -Scope CurrentUser -Force
	}
	if ($PSReadline.Count -eq 0) {
		Install-Module PSReadline -Scope CurrentUser -Force
	}
}
Function LoadAtStart() {
	cls # Clear Load logs
	Import-Module posh-git #-AllowPrerelease -Force
	Import-Module oh-my-posh
	Set-Theme Darkblood # Available themes <C:\Users\<UserName>\Documents\PowerShell\Modules\oh-my-posh\2.0.449\Themes\Darkblood.psm1>
	screenfetch # Run Screenfetch
}
try {
	# Verify Module in The Background
	Start-Job -Name VerifyM -ScriptBlock {VerifyModule}
	LoadAtStart
}
catch {
	Write-Output $error
	# # Check PowerLine existances
	# $PoshGit = Get-InstalledModule -Name "posh-git"
	# $OhMyPosh = Get-InstalledModule -Name "oh-my-posh"
	# $PSReadline = Get-InstalledModule -Name "PSReadline"
	# # Check Powershell Edition, Core edition and Desktop edition maybe need to have different modules
	# $Edition = $PSVersionTable.PSEdition
	# # Check Windows-Screenfetch module (https://github.com/JulianChow94/Windows-screenFetch)
	# $WindowsScreenfetch = Find-Module -Name "windows-screenfetch"
	# 	
	# if ($PoshGit.Count -eq 0) {
	# 	Install-Module posh-git -Scope CurrentUser -Force
	# }
	# if ($OhMyPosh.Count -eq 0) {
	# 	Install-Module oh-my-posh -Scope CurrentUser -Force
	# }
	# if ($WindowsScreenfetch.Count -eq 0) {
	# 	# The error might be occurs when ran on Core edition because the module have legacy code
	# 	# And need to change some of the code from Get-WMIObject to Get-CimInstance to do it work properly
	# 	Install-Module windows-screenfetch -Scope CurrentUser -Force
	# }
	# #LoadAtStart
	# if ($PoshGit.Count -ne 0 -And $OhMyPosh.Count -ne 0) {
	# 	if ($Edition -eq 'Core') {
	# 		if ($PSReadline.Count -eq 1) {
	# 			LoadAtStart
	# 		}
	# 		else {
	# 			Install-Module PSReadline -Scope CurrentUser -Force
	# 		}
	# 	}
	# 	else {
	# 		LoadAtStart
	# 	}
	# }
}
