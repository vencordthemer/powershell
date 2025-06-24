# Install Oh My Posh
if (-not (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Oh My Posh..." -ForegroundColor Cyan
    winget install JanDeDobbeleer.OhMyPosh -s winget
} else {
    Write-Host "Oh My Posh is already installed." -ForegroundColor Green
}

# Create theme directory
$themeDir = "$HOME/.powershell-themes"
if (-not (Test-Path $themeDir)) {
    New-Item -ItemType Directory -Path $themeDir | Out-Null
    Write-Host "Created theme directory at $themeDir" -ForegroundColor Green
} else {
    Write-Host "Theme directory already exists." -ForegroundColor Yellow
}

# Copy all .omp.json themes from local ./themes folder to ~/.powershell-themes
$localThemeFolder = Join-Path $PSScriptRoot "themes"
if (Test-Path $localThemeFolder) {
    Get-ChildItem "$localThemeFolder\*.omp.json" | ForEach-Object {
        Copy-Item $_.FullName -Destination $themeDir -Force
        Write-Host "Copied theme: $($_.Name)" -ForegroundColor Cyan
    }
} else {
    Write-Host "No local themes folder found. Skipping theme copy." -ForegroundColor Red
}

# Update PowerShell profile with startup script
$startupScriptPath = Join-Path $PSScriptRoot "startup.ps1"
if (Test-Path $startupScriptPath) {
    Copy-Item $startupScriptPath -Destination $PROFILE -Force
    Write-Host "PowerShell profile updated at $PROFILE" -ForegroundColor Green
} else {
    Write-Host "startup.ps1 not found. Profile not updated." -ForegroundColor Red
}

Write-Host "`n Setup complete! Restart PowerShell to see the changes." -ForegroundColor Green
