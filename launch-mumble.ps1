if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$time = Read-Host("Time to wait before launching")

Write-Host("Killing old mumble")
Stop-Process -Name "Mumble" -Force

Write-Host("Waiting $time seconds")
Start-Sleep -Seconds $time

Write-Host("starting Mumble minimised")
Start-Process mumble://10.0.10.11 -WindowStyle Minimized