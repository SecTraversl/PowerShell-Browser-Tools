<#
.SYNOPSIS
  The "Invoke-ChromeBrowser" function launches Chrome.exe (-incognito mode is used by default unless '-NoIncognito' is specified).  If one or many URLs are given to the '-URL' parameter then a browser tab for each URL will also be opened.
  
.EXAMPLE
  PS C:\> $links = @('https://github.com/MarkBaggett/pxpowershell','https://github.com/MarkBaggett/pxpowershell/stargazers')
  PS C:\> ChromeBrowser -URL $links



  Here we first place an array of URLs we want to visit as values to the '$links' variable.  We then use the "Invoke-ChromeBrowser" function by referencing its built-in alias of 'ChromeBrowser' along with specifying the $links variable with the "-URL" parameter in order to open Chrome with a tab for each site that we specified.

.NOTES
  Name:  Invoke-ChromeBrowser.ps1
  Author:  Travis Logue
  Version History:  2.1 | 2022-01-21 | Total update of the tool
  Dependencies:  
  Notes:
  - 

  .
#>
function Invoke-ChromeBrowser {
  [CmdletBinding()]
  [Alias('ChromeBrowser')]
  param (
    [Parameter()]
    [string[]]
    $URL,
    [Parameter()]
    [string]
    $Path,
    [Parameter()]
    [switch]
    $NoExperiments,
    [Parameter()]
    [switch]
    $DisableExtensions,
    [Parameter()]
    [switch]
    $NoIncognito
  )
  
  begin {}
  
  process {

    if ($Path) {
      $Exe = Get-Item $Path
    }
    else {
      
      if (Test-Path -Path "$($env:ProgramFiles)\Google\Chrome\Application\chrome.exe" -PathType Leaf) {
        $Exe = Get-Item "$($env:ProgramFiles)\Google\Chrome\Application\chrome.exe"
      }
      elseif (Test-Path -Path "$(${env:ProgramFiles(x86)})\Google\Chrome\Application\chrome.exe" -PathType Leaf) {
        $Exe = Get-Item "$(${env:ProgramFiles(x86)})\Google\Chrome\Application\chrome.exe"
      }
      else {
        Write-Host "`n'Chrome.exe' was not found in one of the typical locations.  Please specify the path using the '-Path' parameter`n" -BackgroundColor Black -ForegroundColor Yellow
      }

    }

    if ( -not ($NoIncognito) ) {
      $param = @('--incognito')     
    }

    if ($NoExperiments) {
      $param += @('--no-experiments')
    }
    
    if ($DisableExtensions) {
      $param += @('--disable-extensions')
    }

    if ($URL) {
      foreach ($eachUrl in $URL) {
        $TempParams = $null
        $TempParams = $param + @($eachUrl)
        & $Exe $TempParams
      }
    }
    else {
      & $Exe $param
    }

    
  }
  
  end {}
}