# Call commands at startup
Function LoadAtStart() {
	cls # Clear Load logs
	Import-Module posh-git
	Import-Module oh-my-posh
	Set-Theme Paradox
	screenfetch # Run Screenfetch
	#Set-Theme Sorin
}

# Check PowerLine existances
$PoshGit = Get-InstalledModule -Name "posh-git"
$OhMyPosh = Get-InstalledModule -Name "oh-my-posh"
$PSReadline = Get-InstalledModule -Name "PSReadline"
$Edition = $PSVersionTable.PSEdition

if ($PoshGit.Count -eq 0) {
	Install-Module posh-git -Scope CurrentUser -Force
}
if ($OhMyPosh.Count -eq 0) {
	Install-Module oh-my-posh -Scope CurrentUser -Force
}
if ($PoshGit.Count -ne 0 -And $OhMyPosh.Count -ne 0) {
	if ($Edition -eq 'Core') {
		if ($PSReadline.Count -eq 1) {
			LoadAtStart
		} else {
			Install-Module PSReadline -Scope CurrentUser -Force
		}
	} else {
		LoadAtStart
	}
}
