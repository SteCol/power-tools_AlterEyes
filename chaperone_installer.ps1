# Gathering logs from %AppData% from all the pc's

# Set the destination to copy to
$source = Read-Host('Source')

# Set all the string parameters for name giving and such
# C:\ProgramData\Steam\config
$dests = "\\10.0.10.21", "\\10.0.10.22", "\\10.0.10.23", "\\10.0.10.24"
$index = "1", "2", "3", "4"
$title = "Lobby", "PE", "CoC", "Fiesta"
$files = "chaperone_info.vrchap", "steamvr.vrsettings", "version.info"
$datetime = Get-Date -Format "dd-MM-yyyy_hh-mm"

Write-Host("===============================================")

For ($i=0; $i -le 3; $i++) {
    For ($j=0; $j -le 2; $j++) {
        $fullDest = $dests[$i] + "\ProgramData\Steam\config\"
        $fullSource =  $source+ "\" + $files[$j]
        Write-Host("Copying " + $fullSource + " --> " + $fullDest)
        copy $fullSource $fullDest
    }
    Write-Host("===============================================")
}

Pause
