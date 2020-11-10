@echo off

setlocal EnableDelayedExpansion

net session >nul 2>&1
if %errorLevel% == 0 (
    echo [+] Checking for ADMIN privileges ... OK!
) else (
    echo [-] You must run this script as admin!
    exit 1
)

::
:: Remove 'Cast to Device...' from context menu
::
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V {7AD84985-87B4-4a16-BE58-8B72A5B390F7} /t REG_SZ /d "Play to Menu" /f
