# Gathering logs from %AppData% from all the pc's

# Set the destination to copy to
$source = Read-Host('Source')

# Set all the string parameters for name giving and such
# C:\ProgramData\Steam\config
$dests = "\\dojogame_001\C", "\\dojogame_002\C", "\\dojogame_003\C", "\\dojogame_004\C"
$index = "1", "2", "3", "4"
$title = "Lobby", "PE", "CoC", "Fiesta"
$files = "steamvr.vrsettings",""
$datetime = Get-Date -Format "dd-MM-yyyy_hh-mm"

Write-Host("===============================================")

For ($i=0; $i -le 3; $i++) {
    For ($j=0; $j -le 2; $j++) {
        $fullDest = $dests[$i] + "\ProgramData\Steam\config\"
        $fullSource =  $source+ "\" + $files[$j]
        Write-Host("Copying " + $fullSource + " --> " + $fullDest)
        Pause
        copy $fullSource $fullDest
    }
    Write-Host("===============================================")
}

Pause
