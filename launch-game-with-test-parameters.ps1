$path = Read-Host("Path")
Start-Process -FilePath "$path" -ArgumentList "`"--game-config:` C:\\Users\\stefc\\Temp\\photonSetup.json`"", "`"--game-config:` C:\\Users\\stefc\\Temp\\SpectatorSetup.json`"", "`"--game-config:` C:\\Users\\stefc\\Temp\\PCSetup.json`""
