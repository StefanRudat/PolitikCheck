$ErrorActionPreference = "Stop"
$classes = [Microsoft.Win32.RegistryKey]::OpenBaseKey(
    [Microsoft.Win32.RegistryHive]::CurrentUser,
    [Microsoft.Win32.RegistryView]::Default
)
try {
    $classes.DeleteSubKeyTree("Software\Classes\politikcheck", $false)
}
finally {
    $classes.Dispose()
}

$shortcut = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\PolitikCheck.lnk"
if (Test-Path $shortcut) { Remove-Item $shortcut -Force }

$installDir = Join-Path $env:LOCALAPPDATA "Programs\PolitikCheck"
if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }
Write-Host "PolitikCheck wurde entfernt."
