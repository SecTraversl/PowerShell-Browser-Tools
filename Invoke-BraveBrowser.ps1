<#
.SYNOPSIS
  The "Invoke-BraveBrowser" function launches Brave.exe (-incognito mode is used by default unless '-NoIncognito' is specified).  If one or many URLs are given to the '-URL' parameter then a browser tab for each URL will also be opened.
  
.EXAMPLE
  PS C:\> $links = @('https://github.com/MarkBaggett/pxpowershell','https://github.com/MarkBaggett/pxpowershell/stargazers')
  PS C:\> BraveBrowser -URL $links



  Here we first place an array of URLs we want to visit as values to the '$links' variable.  We then use the "Invoke-BraveBrowser" function by referencing its built-in alias of 'BraveBrowser' along with specifying the $links variable with the "-URL" parameter in order to open Brave with a tab for each site that we specified.

.NOTES
  Name:  Invoke-BraveBrowser.ps1
  Author:  Travis Logue
  Version History:  2.1 | 2022-01-21 | Total update of the tool
  Dependencies:  
  Notes:
  - 

  .
#>
function Invoke-BraveBrowser {
  [CmdletBinding()]
  [Alias('BraveBrowser')]
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
      
      if (Test-Path -Path "$($env:ProgramFiles)\BraveSoftware\Brave-Browser\Application\brave.exe" -PathType Leaf) {
        $Exe = Get-Item "$($env:ProgramFiles)\BraveSoftware\Brave-Browser\Application\brave.exe"
      }
      elseif (Test-Path -Path "$(${env:ProgramFiles(x86)})\BraveSoftware\Brave-Browser\Application\brave.exe" -PathType Leaf) {
        $Exe = Get-Item "$(${env:ProgramFiles(x86)})\BraveSoftware\Brave-Browser\Application\brave.exe"
      }
      else {
        Write-Host "`n'Brave.exe' was not found in one of the typical locations.  Please specify the path using the '-Path' parameter`n" -BackgroundColor Black -ForegroundColor Yellow
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