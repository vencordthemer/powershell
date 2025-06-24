# Clear the screen
Clear-Host

# Set variables
$width = $Host.UI.RawUI.WindowSize.Width
$text = "Welcome to PowerShell"
$padding = [Math]::Max(0, ($width - $text.Length) / 2)
$themeLocation = "$HOME/.powershell-themes"
$themeName = "THEME" # you can change this to your theme name (eg: if my file name was 'dark.omp.json', you would write 'dark' here


# Write centered welcome message in blue
Write-Host (" " * $padding + $text) -ForegroundColor Blue

# Start Oh My Posh with theme
oh-my-posh init pwsh --config "$themeLocation/$themeName.omp.json" | Invoke-Expression
