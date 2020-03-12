# Gathering logs from %AppData% from all the pc's



# local script location
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
Write-Host("local dir is " + $ScriptDir)

$datetime = Get-Date -Format "dd-MM-yyyy_hh-mm"
Write-Host("time: " + $datetime)

# Set the destination to copy to
# $dest = Read-Host('Destination')
$dest = $ScriptDir + "\logs_" + $datetime
Write-Host("Making dir at " + $dest)
New-Item "$dest" -ItemType Directory

# Make a notes file
Write-Host("Making README at " + "$dest\README.txt")
New-Item "$dest\README.txt"

$note = Read-Host('Note')
Write-Host("Writing $note to README at " + "$dest\README.txt")
Set-Content "$dest\README.txt" $note

# Pause

# Set all the string parameters for name giving and such
$sources = "W:", "X:", "Y:", "Z:", "C:\Users\dojo_admin"
$index = "1", "2", "3", "4", "0"
$title = "Lobby", "PE", "CoC", "Fiesta"
$games = "AlterEyes\Dojo_Lobby\Player.log", "AlterEyes\PointyEnds\output_log.txt", "FlatHillGames\ClashOfChefsVR\output_log.txt", "MakeReal\Loco Dojo\output_log.txt"

For ($j = 0; $j -le 3; $j++) {

    # Make a new directory to store the file in per game
    $newDir = $dest + "\" + $title[$j] + "_" + $datetime
    New-Item "$newDir" -ItemType Directory
    Write-Host("Made New Directory " + $newDir)

    # Copy the files per pc to the correct game folder
    For ($i = 0; $i -le 4; $i++) {
        $fullpath = $sources[$i] + "\AppData\LocalLow\" + $games[$j]
        $fulldest = $newDir + "\" + $title[$j] + "_p" + $index[$i] + "_" + $datetime + ".txt"
        Write-Host("Copying " + $fullpath + " to " + $fulldest)
        copy $fullpath $fulldest
    }

    # Comress the folder to make it faster to send to developers
    $zipPath = "$newDir" + ".zip"
    Compress-Archive -Path $newDir -DestinationPath $zipPath
    Write-Host("Compressed " + $newDir + " to " + $zipPath)

    # Delete the non-comressed folder
    Remove-Item -LiteralPath $newDir -Force -Recurse
    Write-Host("Deleted original dir " + $newDir )
}

# Pause
