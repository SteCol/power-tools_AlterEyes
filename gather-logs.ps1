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
$readmeFile = $dest + "\README.txt"

Write-Host("Making README at $readmeFile")
New-Item $readmeFile
$location = Read-Host('Location')
$note = Read-Host('Note')

Write-Host("Writing $note to README at  $readmeFile")
# Set-Content "$dest\README.txt" $note

Add-Content $readmeFile "# Logs"
Add-Content $readmeFile ""
Add-Content $readmeFile "## Info"
Add-Content $readmeFile "* Location: $location"
Add-Content $readmeFile "* Session: $datetime"
Add-Content $readmeFile ""
Add-Content $readmeFile "## Note"
Add-Content $readmeFile "* $note"

# Pause

# Set all the string parameters for name giving and such
$sources = "W:", "X:", "Y:", "Z:", "V:"
$sourcesB = "Y:", "X:", "W:", "V:", "Z:"
$index = "1", "2", "3", "4", "0"
$commonTitle = "Lobby", "PE", "CoC", "Fiesta"
$NASTarget = "U:\Logs\"


$appdataTitle = "AppData_Lobby", "AppData_PE", "AppData_CoC", "AppData_Fiesta"
$appdataGames = "AlterEyes\Dojo_Lobby\Player.log", "AlterEyes\PointyEnds\output_log.txt", "FlatHillGames\ClashOfChefsVR\output_log.txt", "MakeReal\Loco Dojo\output_log.txt"

$LogTitles = "Log_Lobby", "Log_PE", "Log_CoC", "Log_Fiesta"
$logName = "dojogame-001", "dojogame-002", "dojogame-003", "dojogame-004", "dojoserv-001"
$logGames = "Lobby.log", "PointyEnds.log", "ClashOfChefsVR.log", "Loco Dojo.log"


For ($j = 0; $j -lt $appdataGames.Length; $j++) {

    # Make a new directory to store the file in per game
    $newDir = $dest + "\" + $commonTitle[$j] + "_" + $datetime
    New-Item "$newDir" -ItemType Directory
    Write-Host("Made New Directory " + $newDir)

    # Copy the files per pc to the correct game folder
    For ($i = 0; $i -lt $sourcesB.Length; $i++) {
        $fullpath = $sourcesB[$i] + "\AppData\LocalLow\" + $appdataGames[$j]
        $fulldest = $newDir + "\" + $appdataTitle[$j] + "_p" + $index[$i] + "_" + $datetime + ".log"
        Write-Host("Copying " + $fullpath + " to " + $fulldest)
        copy $fullpath $fulldest

        $fullpath = "{0}\Logs\{1}_{2}" -f $sourcesB[$i], $logName[$i], $logGames[$j]  
        $fulldest = $newDir + "\" + $LogTitles[$j] + "_p" + $index[$i] + "_" + $datetime + ".log"
        Write-Host("Copying " + $fullpath + " to " + $fulldest)
        copy $fullpath $fulldest
    }

    $archive = $true

    Write-Host("archiving...")

    if ($archive) {
        # Comress the folder to make it faster to send to developers
        $zipPath = "$newDir" + ".zip"
        Compress-Archive -Path $newDir -DestinationPath $zipPath
        Write-Host("Compressed " + $newDir + " to " + $zipPath)

        # Delete the non-comressed folder
        Remove-Item -LiteralPath $newDir -Force -Recurse
        Write-Host("Deleted original dir " + $newDir )
    }else{
        Write-Host("archiving is false, not archiving")
    }
}

Write-Host("Copying files to NAS ({0} --> {1})" -f $dest,$NASTarget)
Copy-Item -Path $dest -Destination $NASTarget -recurse
Remove-Item -LiteralPath $dest -Force -Recurse

