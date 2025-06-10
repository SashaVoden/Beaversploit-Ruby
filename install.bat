@echo off
set "SRC=%~dp0"
set "DEST=%ProgramFiles%\BeaverSploit-Ruby"

echo Installing BeaverSploit-Ruby to %DEST%...
xcopy /E /I /Y "%SRC%" "%DEST%"
if %ERRORLEVEL%==0 (
   echo Installation complete.
) else (
   echo Error during installation.
)
pause