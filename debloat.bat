::
:: Remove 'Cast to Device...' from context menu
::
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V {7AD84985-87B4-4a16-BE58-8B72A5B390F7} /t REG_SZ /d "Play to Menu" /f
