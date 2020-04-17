# Where do you want the file to go?
$dest = Read-Host("destination")
# $gameIndex = Read-Host('game (000-999)')
$changes = Read-Host("changes")


# vars
$games = "000", "001", "002", "003"
$companies = "AlterEyes", "FlatHill Games", "Polygoat", "MakeReal"
$gameNames = "Lobby", "Clash of Chefs: Chaos Kitchen", "PointyEnds", "Loco Dojo: Fiesta"
$streamingAssetPaths = "\Dojo_Lobby_Data\StreamingAssets", "\ClashOfChefsVR_Data\StreamingAssets", "\PointyEnds_Data\StreamingAssets", "\Loco Dojo_Data\StreamingAssets"


#Delete streaming assets


$buildFile = "$dest\build.info"

# Desired outcome:
#   |# GAME NAME
$gameText = ""
#   |
#   |## Version
#   |* compamy name
$companyText = ""
#   |* version
$dest = $dest.Replace('\', '/')
Write-Host("new dest is $dest");
$destArray = $dest.Split('/')
Write-Host($destArray);
$versionText = $destArray[$destArray.Length - 1]
#   |## Changelog
#   |* change 1
$changeTextArray = $changes.Split("*")
# $changeText = $changes

#   |* change 2

# write game name
Write-Host("Writing $gameName to $buildFile")

For ($i = 0; $i -le $games.Length - 1; $i++) {
    Write-Host("checking " + $destArray[$destArray.Length - 2] + " with " + $games[$i])
    if ($destArray[$destArray.Length - 2].Contains($games[$i])) {
        Write-Host("generating file for " + $gameNames[$i])
        $gameText = $games[$i] + " | " + $gameNames[$i]
        $companyText = $companies[$i]

        $streamingAssetsPath = $dest + $streamingAssetPaths[$i]
        Write-Host("Deleting StramingAssets in " + $streamingAssetsPath)
        Remove-Item $streamingAssetsPath -recurse
        New-Item $streamingAssetsPath -itemtype directory
    } 
}

Write-Host("Writing $gameName to $buildFile")


Write-Host("Generating Build file $buildFile ...")
if (Get-Item $buildFile) {
    Write-Host("Removing Previous $buildFile ...")
    Remove-Item $buildFile
}
New-Item $buildFile

Write-Host "# $gameText"
Write-Host ""
Write-Host "## Info"
Write-Host "* $companyText"
Write-Host "* $versionText"
Write-Host ""
Write-Host "## Changelog"

For ($i = 0; $i -le $changeTextArray.Length - 1; $i++) {
    $t = $changeTextArray[$i]
    Write-Host "* $t"
}


Add-Content $buildFile "# $gameText"
Add-Content $buildFile ""
Add-Content $buildFile "## Info"
Add-Content $buildFile "* $companyText"
Add-Content $buildFile "* $versionText"
Add-Content $buildFile ""
Add-Content $buildFile "## Changelog"
# Add-Content $buildFile "* $changeText"

For ($i = 0; $i -le $changeTextArray.Length - 1; $i++) {

    $t = $changeTextArray[$i]
    Add-Content $buildFile "* $t"
}


Write-Host("... Done!")

