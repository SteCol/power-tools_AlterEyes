Write-Host("Organising logs per game, per spource")

$pcNames = "dojogame-001", "dojogame-002", "dojogame-003", "dojogame-004"
$AppDataFolders = ".appdata.locallow.logs/AlterEyes/Dojo_Lobby/", ".appdata.locallow.logs/AlterEyes/PointyEnds/", ".appdata.locallow.logs/FlatHillGames/ClashOfChefsVR/", ".appdata.locallow.logs/MakeReal/Loco Dojo/"
$AppDataLogNames = "Player.log", "output_log.txt", "output_log.txt", "output_log.txt"
$logFolders = ".logs/" #Add dojogame-00x before
$logNames = "_Lobby.log", "_PointyEnds.log", "_ClashOfChefsVR.log", "_Loco Dojo.log"
$folderNames = "Lobby", "PointyEnds", "ClashOfChefs", "LocoDojo"

$location = Read-Host("Path")
$location = $location  + "/" 

# Make the folders
For ($i = 0; $i -lt $folderNames.Length; $i++) {
    New-Item -Path $location -Name $folderNames[$i] -ItemType "directory"
}

pause


# Copy the appdata files
For ($i = 0; $i -lt $folderNames.Length; $i++) {
    For ($j = 0; $j -lt $folderNames.Length; $j++) {
        $source = $pcNames[$i] + $AppDataFolders[$j] + $AppDataLogNames[$j]
        $target = $location + $folderNames[$j] +"/"+ "AppData_" +$pcNames[$i] + "_"+ $folderNames[$j] + ".log"
        write-host("Goint to copy $source to $target")
        $fullSource = $location + $source
        Copy-Item $fullSource  $target
    }
}

pause

# Copy the log files
For ($i = 0; $i -lt $folderNames.Length; $i++) {
    For ($j = 0; $j -lt $folderNames.Length; $j++) {
        $source = $pcNames[$i] + $logFolders + $pcNames[$i] + $logNames[$j]
        $target = $location + $folderNames[$j] +"/"+ "Log_" +$pcNames[$i] + "_"+ $folderNames[$j] + ".log"
        write-host("Goint to copy $source to $target")
        $fullSource = $location + $source
        Copy-Item $fullSource  $target
    }
}

Pause