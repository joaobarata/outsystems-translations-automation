# outsystems-translations-automation

Set of Powershell scripts used to automate the extraction and import of translations for Outsystems modules from a solution file.

## How to use

In order to streamline the process of updating the translations of multiple modules you can start by creating a solution with the modules you want to update the Translation files.

Clone tor downlaod this repository and move the downloaded solution file to the same folder as the PowerSell scripts.
Note: Solution name can't include special characters like '{' or '['

### Exporting the translations

To export the translations you will need to run the "ExportTranslations" Powershell script by passing two variables:

- -SSPath -> the path to the directory where Service Studio is installed.
  - Defaults to "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
- -SolutionPath -> the path where we have the solution we want to use
  - Defaults to ".\SolutionFile.osp"

At this point, you should see a Solution.zip file, a Solution folder, as well as the translations folder created.
Within the translations folder you will have one ".xls" file per each module of the solution.  
Note: There's currently a bug and only .xls files are being generated using Service Studio via the command line

With this, you already have access to all the translation files for a the modules included in the solution.

### Importing the translations

After performing the changes needed in the translation files, replace the files in the "translations" folder and make sure to keep the same name format as before. eg: "AppName + Language".xls  
Note: you can use XLS or XLSX to import

Then run the "ImportTranslations" PowerShell by passing two parameters:

- -SSPath -> the path to the directory where Service Studio is installed
  - Defaults to "C:\Program Files\OutSystems\Service Studio 11\Service Studio\ServiceStudio.exe"
- -Format -> the format we are importing the files (.xls or .xlsx)
  - Defaults to xls")

If you check the "solution" folder, all modules have been updated with the new language files.

At the moment, this script does not have a mechanism to pack all the modules back in the solution. 
The changed modules will have to manually uploaded the to the environment.