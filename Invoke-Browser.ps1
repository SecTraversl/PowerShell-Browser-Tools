<#
.SYNOPSIS
  The "Invoke-Browser" function will open one or many given URLs using the default web browser.

.EXAMPLE
  PS C:\> $links = @('https://github.com/MarkBaggett/pxpowershell','https://github.com/MarkBaggett/pxpowershell/stargazers')
  PS C:\> browser $links



  Here we use the function by referencing its built-in alias of "browser" and by referencing an array of URLs we want to visit.  In return, the default browser on our system is invoked and two tabs with each of the URLs we referenced are opened.

.NOTES
  Name:  Invoke-Browser.ps1
  Author:  Travis Logue
  Version History:  1.1 | 2022-01-21 | Initial Version
  Dependencies:  
  Notes:
  - Retrieved this idea from here:  https://community.idera.com/database-tools/powershell/ask_the_experts/f/learn_powershell_from_don_jones-24/18285/open-default-web-browser-in-powershell

  .
#>
function Invoke-Browser {
  [CmdletBinding()]
  [Alias('browser')]
  param (
    [Parameter()]
    [string[]]
    $URI
  )
  
  begin {}
  
  process {
    foreach ($item in $URI) {
      Start-Process $item
    }
  }
  
  end {}
}