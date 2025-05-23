# $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# $PROFILE

$OutputEncoding = [System.Text.UTF8Encoding]::new($false)
[System.Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

Invoke-Expression (&starship init powershell)

if (Get-Command lazygit -ErrorAction SilentlyContinue) {
  Set-Alias -Name lg -Value lazygit
  # Write-Host "Alias 'lg' for 'lazygit' created."
}
