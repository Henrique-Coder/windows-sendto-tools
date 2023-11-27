@echo off
chcp 65001 >nul 2>&1
setlocal

set "mainBatchScript=%~dp0anyvideo_to_av1.bat"
set "shortcutName=Transcodes the video to AV1.lnk"

set "assetsDir=%~dp0assets"
set "iconFile=%assetsDir%\icon.ico"
set "sendToDir=%APPDATA%\Microsoft\Windows\SendTo"
set "shortcutPath=%sendToDir%\%shortcutName%"
set "targetPath=%mainBatchScript%"

echo.
if not exist "%mainBatchScript%" (
    echo The main script was not found. Exiting...
    goto endapp
)

if not exist "%iconFile%" (
    echo The icon file was not found. Creating the shortcut without the icon.
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcutPath%'); $Shortcut.TargetPath = '%targetPath%'; $Shortcut.Save()"
) else (
    echo The icon file was found. Creating the shortcut with the icon.
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcutPath%'); $Shortcut.TargetPath = '%targetPath%'; $Shortcut.IconLocation = '%iconFile%'; $Shortcut.Save()"
)

echo Installation completed successfully. Exiting...
goto endapp

:endapp
endlocal
timeout /t 5 >nul 2>&1
exit /b %errorlevel%
