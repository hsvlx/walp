# ============================================================
#  HonestVL.COM - Taskbar & Animation Tweaks
#  Makes taskbar clean, minimal, dark - kills all animations
# ============================================================

Write-Host ""
Write-Host "  HonestVL - Taskbar & Animation Tweaks" -ForegroundColor Cyan
Write-Host ""

# ---- KILL ALL ANIMATIONS ----
Write-Host "[1] Disabling all animations..." -ForegroundColor Yellow

# Visual effects - performance mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f | Out-Null

# Individual animation keys
$animKeys = @{
    "HKCU\Control Panel\Desktop"                                                                    = @{ "UserPreferencesMask" = ([byte[]](0x90,0x12,0x07,0x80,0x10,0x00,0x00,0x00)) }
    "HKCU\Control Panel\Desktop\WindowMetrics"                                                      = @{ "MinAnimate" = "0" }
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"                              = @{
        "TaskbarAnimations"    = 0
        "ListviewAlphaSelect"  = 0
        "ListviewShadow"       = 0
        "ExtendedUIHoverTime"  = 1
    }
    "HKCU\Software\Microsoft\Windows\DWM"                                                           = @{
        "EnableAeroPeek"       = 0
        "AlwaysHibernateThumbnails" = 0
    }
}

foreach ($path in $animKeys.Keys) {
    foreach ($name in $animKeys[$path].Keys) {
        $val = $animKeys[$path][$name]
        if ($val -is [int]) {
            reg add $path /v $name /t REG_DWORD /d $val /f | Out-Null
        } elseif ($val -is [string]) {
            reg add $path /v $name /t REG_SZ /d $val /f | Out-Null
        }
    }
}

# Disable transparency
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f | Out-Null

# Dark mode (matches your setup)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f | Out-Null

Write-Host "    All animations disabled." -ForegroundColor Green

# ---- TASKBAR CLEANUP ----
Write-Host "[2] Cleaning taskbar..." -ForegroundColor Yellow

# Left align taskbar
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f | Out-Null

# Remove Search box
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f | Out-Null

# Remove Task View button
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f | Out-Null

# Remove Widgets
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f | Out-Null

# Remove Chat/Teams
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f | Out-Null

# Remove Copilot button
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f | Out-Null

# Show all tray icons
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f | Out-Null

# Disable News and Interests
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f | Out-Null

# Disable Start menu suggestions/ads
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f | Out-Null

# Disable Start menu recently added apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f | Out-Null

# Disable snap layout suggestions on hover
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableSnapBar /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableTaskGroups /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 0 /f | Out-Null

# Taskbar never combine (show labels) - matches clean look
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarGlomLevel /t REG_DWORD /d 2 /f | Out-Null

Write-Host "    Taskbar cleaned." -ForegroundColor Green

# ---- START MENU CLEANUP ----
Write-Host "[3] Cleaning Start menu..." -ForegroundColor Yellow

# Disable recommended section in Start
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f | Out-Null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoRecentDocsHistory /t REG_DWORD /d 1 /f | Out-Null

# Disable web results in search
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f | Out-Null

Write-Host "    Start menu cleaned." -ForegroundColor Green

# ---- EXPLORER TWEAKS ----
Write-Host "[4] Explorer tweaks..." -ForegroundColor Yellow

# Open to This PC
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f | Out-Null

# Show file extensions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f | Out-Null

# Show hidden files
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f | Out-Null

# Disable quick access recent files
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f | Out-Null
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f | Out-Null

Write-Host "    Explorer tweaked." -ForegroundColor Green

# ---- RESTART EXPLORER ----
Write-Host "[5] Restarting Explorer to apply changes..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Milliseconds 1000
Start-Process explorer
Write-Host "    Done." -ForegroundColor Green

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host "   HonestVL Taskbar Tweaks Complete!" -ForegroundColor Cyan
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host ""
