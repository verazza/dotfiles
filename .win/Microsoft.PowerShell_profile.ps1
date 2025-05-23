# $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# $PROFILE

$OutputEncoding = [System.Text.UTF8Encoding]::new($false)
[System.Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

Invoke-Expression (&starship init powershell)

if (Get-Command lazygit -ErrorAction SilentlyContinue) {
  Set-Alias -Name lg -Value lazygit
  # Write-Host "Alias 'lg' for 'lazygit' created."
}

# php-cs-fixerが存在する場合、環境変数を設定
if (Get-Command php-cs-fixer -ErrorAction SilentlyContinue) {
    $env:PHP_CS_FIXER_IGNORE_ENV = "1"
    # Write-Host "Environment variable 'PHP_CS_FIXER_IGNORE_ENV' set to 1 because php-cs-fixer was found."
}
