# Function to check if the script is running as Administrator
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Relaunch script as Administrator if not already elevated
if (-Not (Test-Admin)) {
    Write-Host "Script is not running as Administrator. Relaunching with elevated privileges..."
    Start-Process -FilePath "powershell.exe" -ArgumentList "-noexit -NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# Path to the folder containing the font files
$fontFolder = Join-Path -Path $PSScriptRoot -ChildPath "JetBrainsMono"

# Path to the system fonts folder
$systemFontsFolder = "$env:SystemRoot\Fonts"

# Get all .ttf and .otf font files from the folder
$fontFiles = Get-ChildItem -Path $fontFolder -Include *.ttf, *.otf -Recurse

foreach ($font in $fontFiles) {
    # Destination path in the system fonts folder
    $destination = Join-Path -Path $systemFontsFolder -ChildPath $font.Name
    $fontName = $font.Name

    # Check if the font is already installed
    if (-Not (Test-Path -Path $destination)) {
        # Copy the font to the system fonts folder
        Copy-Item -Path $font.FullName -Destination $destination -Force

        # Register the font in the Registry
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $font.BaseName -Value $fontName -PropertyType String
        Write-Host "Installed font: $fontName"
    } else {
        Write-Host "Font already installed: $fontName"
    }
}

winget install JanDeDobbeleer.OhMyPosh -s winget

echo $env:POSH_THEMES_PATH

Copy-Item "$PSScriptRoot/Microsoft.PowerShell_profile.ps1" -Destination "$env:USERPROFILE/Documents/WindowsPowerShell" -Recurse -Force

Install-Module -Name Terminal-Icons -Repository PSGallery

Copy-Item -Path "$PSScriptRoot/windows-terminal.json" -Destination "C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force