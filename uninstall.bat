@echo off
set "DEST=%ProgramFiles%\BeaverSploit-Ruby"

echo Uninstalling BeaverSploit-Ruby from %DEST%...
rmdir /S /Q "%DEST%"
if %ERRORLEVEL%==0 (
   echo Uninstallation complete.
) else (
   echo Error during uninstallation.
)
pause