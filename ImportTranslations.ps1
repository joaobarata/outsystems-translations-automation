<#
.SYNOPSIS

Script used to export the translation files of a solution.

.DESCRIPTION

Script used to export the translation files of a solution.

.PARAMETER InputPath
[string] -SSPath - Path for 'Service Studio'. Defaults to "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
[string] -Format - Format for the translations files. Defaults to xls")


.INPUTS

None.

.OUTPUTS

None.

.EXAMPLE

PS> .\ImportTranslations.ps1

.EXAMPLE

PS> .\ImportTranslations.ps1 -SSPath "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"" -Format xlsx

#>

param
(
    # Enter the path for the 'Service Studio'. Defaults to "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
    [string] $SSPath = "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe",
    # Enter the format for the translations files. Defaults to xls"
    [string] $Format = "xls"
)
if (-not(Test-Path -Path $SSPath)) {
    Write-Error "'Service Studio Path not found '$($SSPath)', please provide it using the -SSPath flag"
    return
}

function Import-Translations{
    Param (
        [Parameter(Mandatory = $true)] [string] $SSPath,
        [Parameter(Mandatory = $true)] [string] $Format
    )

    $folder = Get-ChildItem ".\Solution\" -Directory
    Get-ChildItem $folder.FullName -Filter *.oml |
    Foreach-Object {
        $translationvariable = ".\translations\" +$_.Basename +"Language."+ $Format
        Start-Process -NoNewWindow -FilePath $ssPath -ArgumentList "-import", $_.FullName, $translationvariable
    }
}

Import-Translations $SSPath $Format
