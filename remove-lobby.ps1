# Elevate to administrator privileges
# if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# Startup
Write-Host  '==== Starting: Deleting Logs ====';

#Copy the .json files to all pc's
#ps script root var: $PSScriptRoot

$game = Read-Host -Prompt 'Game Name (game id of log)'

For($i=1; $i -lt 5; $i++){
    $pc = "dojogame-00$i"
    $location = "\\$pc\users\dojo_admin\Dojo\game-library\executables\$game*"

    Write-Host "$pc"
    Write-Host "$location"

    Read-Host  'Continue?';

    Remove-Item $location
}