# AlterEyes_PowerTools

## Content

These PowerTools are used for AlterEyes and other systems to automise tasks such at removing, archiving, gathering files, and more!

### chaperone_installer.ps1

* **Depricated**, chaperones are installed manually.
* Must update to facilitate new install flow.

### delete-logs.ps1

* Cycles through pc's `user/logs` folder and deletes them. 
* Use with caution.

### DisconnectRDP.ps1

* Disconnected Remote Desktop session from client pc.
* Use to disconnect RDP without breaking VR games on startup.

### gather-logs.ps1

* Copies the `AppData/LocalLow` logs to a dated folder.
* Run from dojoserv-001.

### launch-game-with-test-parameters.ps1

### launch-Mumble

### RDP_Dojo

* Opens 5 remote connections to dojoserv and dojogame pc's respectively.
* Use from laptop

### RDP_Mule

* Same as RDP_Dojo, but using hardcoded IP.

### remove-lobby.ps1

* Uninstalls Lobby when glm tries to reinstall when lobby is still running.

### reorgamise_per_game.ps1

* When getting logs collection from Molenheide or other, organise logs per game, instead of per pc.
