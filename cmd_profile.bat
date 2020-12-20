@echo off

setlocal EnableDelayedExpansion

set ALIASFILE="%USERPROFILE%\config\cmd_profile.bat"
set SUBLIME="%ProgramFiles%\Sublime Text 3\sublime_text.exe"
set SYS32="\Windows\System32"

doskey dt=cd /D "%USERPROFILE%\Desktop"
doskey dl=cd /D "%USERPROFILE%\Downloads"
doskey man=help $*
doskey mv=move $*
doskey take=mkdir $* $T$T cd $*
doskey history=doskey /history
doskey traceroute=tracert $*
doskey st=%SUBLIME% $*
doskey ise=powershell_ise.exe $*
doskey alias=!st! %ALIASFILE%
doskey aliases=type %ALIASFILE%
