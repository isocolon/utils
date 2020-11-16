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


::
:: Remove 3D Objects
::
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f


::
:: Disable Sync Provider Notifications
::
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f


::
:: Prevent Candy Crush and other bloatware from being installed
::
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f


::
:: Block preloading of Edge
:: https://www.ghacks.net/2018/08/13/block-windows-10-from-preloading-microsoft-edge-on-start/
::
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v AllowTabPreloading /t REG_DWORD /d 0 /f


::
:: Disable SearchIndexer service
::
sc stop "WSearch"
sc config "WSearch" start= disabled


::
:: Disable SearchApp.exe
::
taskkill /f /im "SearchApp.exe" && mv "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy" "C:\Windows\SystemApps\DISABLED_Microsoft.Windows.Search_cw5n1h2txyewy"
