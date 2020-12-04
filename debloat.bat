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


::
:: Remove Cortana activation task
::
Get-ScheduledTask | where { $_.TaskPath -like "*Agent Activation Runtime*" } | Unregister-ScheduledTask -Confirm:$false
Remove-Item -Path "C:\Windows\System32\Tasks\Agent Activation Runtime"


::
:: Remove 'Open file location' from context menu
::
reg delete "HKCR\lnkfile\shellex\ContextMenuHandlers\OpenContainingFolderMenu" /f
reg delete "HKCR\LibraryLocation\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu" /f
reg delete "HKCR\Results\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu" /f
reg delete "HKCR\.symlink\shellex\ContextMenuHandlers\OpenContainingFolderMenu" /f


::
:: Remove 'Pin to Quick Access'
::
reg delete "HKCR\Folder\shell\pintohome" /f


::
:: Remove 'Troublshoot compatibility'
::
:: NOTE: Requires restarting Explorer
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{1d27f844-3a1f-4410-85ac-14651078412d}" /t REG_SZ /f


::
:: Remove 'Unpin from Taskbar' and 'Pin to Taskbar'
::
reg delete "HKCR\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}" /f


::
:: Remove 'Restore previous versions' from context menu
::
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f


::
:: Remove 'Previous Versions' tab from file properties window
::
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f


::
:: Remove Edit with Paint 3D
::
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jfif\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.tif\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.tiff\Shell\3D Edit" /f


::
::
:: Remove 'Share' from context menu
::
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f


::
:: Remove 'Give access to'
::
reg delete "HKLM\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\Directory\shellex\CopyHookHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\Directory\shellex\PropertySheetHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\Drive\shellex\PropertySheetHandlers\Sharing" /f
reg delete "HKLM\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\Sharing" /f


::
:: Remove 'Pin to Start' from context menu
::
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f
reg delete "HKCR\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen" /f
reg delete "HKCR\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" /f


::
:: Remove 'Open in new window' from context menu
::
:: You CANNOT do reg delete "HKCR\Folder\shell\opennewwindow" /f
:: https://superuser.com/a/1507509
reg add "HKCR\Folder\shell\opennewwindow" /v ProgrammaticAccessOnly /t REG_SZ


::
:: Remove 'Open in Visual Studio' from context menu
:: 
reg delete "HKCR\Directory\Background\shell\AnyCode" /f
reg delete "HKCR\Directory\shell\AnyCode" /f


::
:: Disable 'Show Windows welcome experience'
::
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f


::
:: Disable 'Suggest ways I can finish setting up my device'
::
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f


::
:: Disable 'Get tips, tricks, and suggestions'
::
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f


::
:: Stop and remove xbox services
::
sc config XblAuthManager start= disabled
sc stop XblAuthManager      :: Xbox Live Auth Manager

sc config XblGameSave start= disabled
sc stop XblGameSave         :: Xbox Live Game Save

sc config XboxGipSvc start= disabled
sc stop XboxGipSvc          :: Xbox Accessory Management Service

sc config XboxNetApiSvc start= disabled
sc stop XboxNetApiSvc       :: Xbox Live Networking Service



::
:: Restart Explorer to force changes
::
taskkill /f /im "explorer.exe"
explorer.exe
