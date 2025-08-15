# Ensure script runs as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "⚠ Restarting script as Administrator..."
    Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Define paths
$appDataPath = Join-Path $env:APPDATA "TransFlow"
$exePath = Join-Path $appDataPath "transflow-cli.exe"
$downloadUrl = "https://github.com/winorg394/transflowcli/raw/refs/heads/main/transflow-cli.exe"

# Create folder if it doesn't exist
if (-not (Test-Path $appDataPath)) {
    New-Item -ItemType Directory -Path $appDataPath | Out-Null
}

# Download the file
Write-Host "⬇ Downloading TransFlow CLI..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath -UseBasicParsing
Write-Host "✅ Download completed: $exePath"

# Get current System PATH
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")

# Check if folder is already in PATH
if ($currentPath -notlike "*$appDataPath*") {
    $updatedPath = "$currentPath;$appDataPath"
    [System.Environment]::SetEnvironmentVariable("PATH", $updatedPath, "Machine")
    Write-Host "✅ Added $appDataPath to System PATH."
} else {
    Write-Host "ℹ $appDataPath is already in System PATH."
}

Write-Host "🎯 Installation completed. You can now run 'transflow-cli' from any terminal."
