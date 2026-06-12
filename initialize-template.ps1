<#
.SYNOPSIS
Initializes this template for a new AOWIN module.

.DESCRIPTION
Replaces template placeholders with the module name provided at the command
line, renames the module directory, and removes this setup script after it
successfully completes.

.PARAMETER ModuleName
The name of the new AOWIN module.

.EXAMPLE
.\initialize-template.ps1 my-module
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidatePattern('^[A-Za-z0-9_-]+$')]
    [string]$ModuleName
)

$ErrorActionPreference = 'Stop'

$scriptPath = $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath
$templateDirectoryName = 'module_name'
$placeholder = '%module_name%'
$templateDirectoryPath = Join-Path $repoRoot $templateDirectoryName
$moduleDirectoryPath = Join-Path $repoRoot $ModuleName

Set-Location $repoRoot

if (Test-Path -Path $moduleDirectoryPath) {
    throw "Cannot initialize template because '$ModuleName' already exists."
}

$confirmationMessage = @"
This will initialize the AOWIN module template.

The script will:
- Replace '$placeholder' with '$ModuleName' in template files.
- Rename '$templateDirectoryName' to '$ModuleName'.
- Remove this setup script after initialization completes.
"@

if (-not $PSCmdlet.ShouldContinue($confirmationMessage, "Continue?")) {
    Write-Output "Template initialization cancelled."
    return
}

$files = Get-ChildItem -Path $repoRoot -Recurse -File |
    Where-Object {
        $_.FullName -ne $scriptPath -and
        $_.FullName -notlike (Join-Path $repoRoot '.git\*')
    }

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $updatedContent = $content.Replace($placeholder, $ModuleName)

    if ($updatedContent -ne $content) {
        Set-Content -Path $file.FullName -Value $updatedContent -NoNewline
    }
}

if (Test-Path -Path $templateDirectoryPath) {
    Rename-Item -Path $templateDirectoryPath -NewName $ModuleName
}

Remove-Item -Path $scriptPath

Write-Output "Initialized AOWIN module template for '$ModuleName'."
