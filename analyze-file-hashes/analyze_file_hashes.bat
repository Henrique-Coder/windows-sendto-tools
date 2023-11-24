@echo off
chcp 65001 >nul 2>&1
setlocal EnableDelayedExpansion

rem Set terminal title
title Analyze file hashes - Developed at gh@Henrique-Coder/windows-sendto-tools

rem Set input file path
set "input_file_path=%~dpnx1"

rem Calculate hashes and show them
echo.
echo Hashes for file: "%~dpnx1"
set "count=0"
for %%A in (MD5 SHA1 SHA256 SHA384 SHA512) do (
    set /a "count+=1"
    for /f %%B in ('powershell -Command "(Get-FileHash -Path '!input_file_path!' -Algorithm %%A).Hash"') do set "hash_%%A=%%B"
    echo     !count!. %%A: !hash_%%A!
)

:endapp
endlocal
timeout /t 5 >nul 2>&1
exit /b %errorlevel%
