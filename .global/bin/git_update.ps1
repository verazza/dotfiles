<#
.SYNOPSIS
指定されたディレクトリ以下を再帰的に検索し、.git ディレクトリがあれば git fetch と git pull を実行します。
-I フラグを指定すると、定義されたリストのパスに対してのみ処理を行います。
.DESCRIPTION
指定されたディレクトリ以下を再帰的に検索し、各 .git ディレクトリの親ディレクトリで git fetch と git pull を実行します。
-I フラグを指定した場合、スクリプト内に定義されたディレクトリリストにある各パスに対して、再帰的な検索は行わず、直接 git fetch と git pull を実行します。
#>
param(
    [Parameter(Position = 0)]
    [string]$StartDirectory,

    [switch]$Individual
)

# 個別処理を行うディレクトリのリスト
$IndividualDirectories = @(
    "C:\path\to\repo1",
    "C:\path\to\repo2",
    "~\another\repo"
)

function Update-GitRepository {
    param(
        [string]$Path
    )

    if (Test-Path -Path "$Path\.git" -PathType Container) {
        Write-Host "--------------------------------------------------"
        Write-Host "Found .git directory in: $($Path)"
        Push-Location -Path $Path
        Write-Host "Current directory: $(Get-Location)"
        Write-Host "Executing git fetch..."
        git fetch
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Error occurred during git fetch."
        } else {
            Write-Host "Executing git pull..."
            git pull
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Error occurred during git pull."
            } else {
                Write-Host "git pull completed successfully."
            }
        }
        Pop-Location
        Write-Host "--------------------------------------------------"
    } else {
        Write-Warning "No .git directory found in: $($Path)"
    }
}

if ($Individual) {
    Write-Host "Performing individual updates from list:"
    foreach ($Dir in $IndividualDirectories) {
        $ExpandedPath = $Dir
        if ($ExpandedPath -like "~\*") {
            $ExpandedPath = $ExpandedPath.Replace("~", $env:USERPROFILE)
        }
        Update-GitRepository -Path $ExpandedPath
    }
} else {
    if (-not [string]::IsNullOrEmpty($StartDirectory)) {
        $ExpandedStartDirectory = $StartDirectory
        if ($ExpandedStartDirectory -like "~\*") {
            $ExpandedStartDirectory = $ExpandedStartDirectory.Replace("~", $env:USERPROFILE)
        }
        Write-Host "Performing recursive update in: $($ExpandedStartDirectory)"
        Get-ChildItem -Path $ExpandedStartDirectory -Directory -Recurse -Force -Attributes ReparsePoint | ForEach-Object {
            try {
                $Target = Get-Item -Path $_.LinkTarget -Force
                if ($Target -ne $null -and (Test-Path -Path "$($Target.FullName)\.git" -PathType Container)) {
                    Update-GitRepository -Path $Target.FullName
                }
            } catch {
                Write-Warning "Error processing symlink '$($_.FullName)': $($_.Exception.Message)"
            }
        }
        Get-ChildItem -Path $ExpandedStartDirectory -Directory -Recurse -Force | Where-Object {$_.Name -eq ".git"} | ForEach-Object {
            Update-GitRepository -Path $_.Parent.FullName
        }
    } else {
        Write-Host "Usage: $($MyInvocation.MyCommand.Name) [<start_directory>] [-Individual]"
    }
}

Write-Host "Processing completed."
