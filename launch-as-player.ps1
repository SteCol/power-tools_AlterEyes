

$json = Get-Content -Raw -Path "$PSScriptRoot\config.json" | ConvertFrom-Json
[Array]$_versions = $json.versions

Write-Host("Welcome to the Playtest launcher! You have " + $_versions.Length + " versions available")

for ($i=0;$i -lt $_versions.Length ; $i++) {
	Write-Host("[$i] " + $_versions[$i])
}


$Game = Read-Host("Pick one by pressing the number");

$Player = Read-Host("Player (1,2,3 or 4)")
Write-Host($Player);

$target = "" 

for ($i=0;$i -lt $_versions.Length ; $i++) {
	if ($Game -eq $i) {
        $target = $PSScriptRoot + $_versions[$i]
        Write-Host($_versions[$i]);
    }
}

$streamingAssetsDir = $target + "\PointyEnds_SynthesisVR_Data\StreamingAssets"
$GameExecutable = $target + "\PointyEnds_SynthesisVR.exe" 
$ConfigDir = $PSScriptRoot + "\Player Configs\StreamingAssets - Player " + $Player + "\*"

Write-Host($ConfigDir);

Write-Host("Updating config");

Remove-Item $streamingAssetsDir -Recurse -Force

# Copy files over
Copy-Item -Force -Recurse -Verbose -Path $ConfigDir -Destination $streamingAssetsDir

Write-Host("Launching...");

Start-Process -FilePath $GameExecutable
