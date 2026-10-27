$ErrorActionPreference = "Stop"
$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectFile = Join-Path $ProjectDir "PolitikCheck.Windows.csproj"
$PublishDir = Join-Path $ProjectDir "publish\win-x64"

dotnet publish $ProjectFile `
  --configuration Release `
  --runtime win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  -p:IncludeNativeLibrariesForSelfExtract=true `
  --output $PublishDir

Write-Host "Windows-Version erstellt: $PublishDir"
Write-Host "Hinweis: Die Windows-Version wurde im Projekt noch nicht auf einem Windows-PC geprüft."
