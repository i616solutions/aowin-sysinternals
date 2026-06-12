<#
.SYNOPSIS
Writes the current date and time to the screen.

.DESCRIPTION
Provides a template PowerShell function that outputs the current date and time
using the built-in Microsoft.PowerShell.Utility\Get-Date cmdlet.

.EXAMPLE
Get-Date

Outputs the current date and time.
#>

Write-Output (Microsoft.PowerShell.Utility\Get-Date)

