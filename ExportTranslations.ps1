<#
.SYNOPSIS

Script used to export the translation files of a solution.

.DESCRIPTION

Script used to export the translation files of a solution.

.PARAMETER InputPath
[string] -SSPath - Path for 'Service Studio'. Defaults to "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
[string] -SolutionPath - Path for the 'Solution file'. Defaults to ".\SolutionFile.osp"


.INPUTS

None.

.OUTPUTS

None.

.EXAMPLE

PS> .\ExportTranslations.ps1

.EXAMPLE

PS> ..\ExportTranslations.ps1 -SSPath "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"" -SolutionPath ".\MySolution.osp"

#>

param
(
    # Enter the path for the 'Service Studio'. Defaults to C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
    [string] $SSPath = "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe",
    # Enter the path for the 'Solution file'. Defaults to .\SolutionFile.osp"
    [string] $SolutionPath = ".\SolutionFile.osp"
)
if (-not(Test-Path -Path $SSPath)) {
    Write-Error "'Service Studio Path not found '$($SSPath)', please provide it using the -SSPath flag"
    return
}
if (-not(Test-Path -Path $SolutionPath)) {
    Write-Error "'Solution file' not found at '$($SolutionPath)', please provide it using the -SolutionPath flag"
    return
}

function Export-Translations {

    Param (
        [Parameter(Mandatory = $true)] [string] $SSPath,
        [Parameter(Mandatory = $true)] [string] $SolutionPath
    )

    New-Item "translations" -ItemType Directory -Force
    Copy-Item $SolutionPath .\Solution.zip
    Expand-Archive .\Solution.zip -DestinationPath .\Solution\ -Force

    
    $folder = Get-ChildItem ".\Solution\" -Directory
    Get-ChildItem $folder.FullName -Filter *.oml | 
    Foreach-Object {
        Start-Process -NoNewWindow -FilePath $SSPath -ArgumentList "-export", $_.FullName,".\translations","xlsx"
    }
}
Export-Translations $SSPath $SolutionPath