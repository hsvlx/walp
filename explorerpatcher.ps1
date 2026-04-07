# ============================================================
#  HonestVL.COM - ExplorerPatcher Install
#  Removes Win11 Start menu animation, restores clean taskbar
# ============================================================

Write-Host ""
Write-Host "  HonestVL - Installing ExplorerPatcher..." -ForegroundColor Cyan
Write-Host ""

try {
    $installer = "$env:TEMP\ep_setup.exe"
    Write-Host "[1] Downloading ExplorerPatcher..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://github.com/valinet/ExplorerPatcher/releases/latest/download/ep_setup.exe" -OutFile $installer -UseBasicParsing -ErrorAction Stop
    Write-Host "    Downloaded." -ForegroundColor Green

    Write-Host "[2] Installing silently..." -ForegroundColor Yellow
    Start-Process $installer -Wait -ErrorAction Stop
    Write-Host "    Installed." -ForegroundColor Green

    Write-Host "[3] Restarting Explorer..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Milliseconds 1000
    Start-Process explorer
    Write-Host "    Done." -ForegroundColor Green

} catch {
    Write-Host "    [ERROR] Download failed. Check internet connection." -ForegroundColor Red
}

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host "   ExplorerPatcher installed!" -ForegroundColor Cyan
Write-Host "   Start menu animation is now gone." -ForegroundColor Cyan
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host ""
