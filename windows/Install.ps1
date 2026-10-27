$ErrorActionPreference = "Stop"
$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = Join-Path $ProjectDir "publish\win-x64"
$ExeName = "PolitikCheck.exe"
$InstallDir = Join-Path $env:LOCALAPPDATA "Programs\PolitikCheck"
$ExePath = Join-Path $InstallDir $ExeName

if (-not (Test-Path (Join-Path $SourceDir $ExeName))) {
    throw "Windows-Dateien fehlen. Bitte zuerst build.ps1 ausführen."
}

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Copy-Item -Path (Join-Path $SourceDir "*") -Destination $InstallDir -Recurse -Force

$classes = [Microsoft.Win32.RegistryKey]::OpenBaseKey(
    [Microsoft.Win32.RegistryHive]::CurrentUser,
    [Microsoft.Win32.RegistryView]::Default
)
try {
    $protocol = $classes.CreateSubKey("Software\Classes\politikcheck")
    $protocol.SetValue("", "URL:PolitikCheck Protocol")
    $protocol.SetValue("URL Protocol", "")
    $command = $protocol.CreateSubKey("shell\open\command")
    $command.SetValue("", ('"' + $ExePath + '" "%1"'))
    $command.Dispose()
    $protocol.Dispose()
}
finally {
    $classes.Dispose()
}

$startMenu = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut((Join-Path $startMenu "PolitikCheck.lnk"))
$shortcut.TargetPath = $ExePath
$shortcut.WorkingDirectory = $InstallDir
$shortcut.Description = "Lokaler politischer Faktencheck mit Ollama"
$shortcut.Save()

Write-Host "PolitikCheck installiert: $ExePath"
Write-Host "Das URL-Protokoll politikcheck:// ist für den Firefox-Helfer registriert."
Write-Host "Windows-Version: noch nicht durch das Projektteam überprüft."
