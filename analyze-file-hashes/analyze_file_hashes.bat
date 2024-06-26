@echo off
chcp 65001 >nul 2>&1
setlocal EnableDelayedExpansion

rem Set terminal title
title Analyze file hashes - Developed at gh@Henrique-Coder/windows-sendto-tools

rem Check if a file is provided as argument
if "%~1"=="" (
    echo No file specified. Usage: analyze_hashes.bat [file_path]
    pause >nul
    exit /b 1
)

rem Set input file path
set "input_file_path=%~dpnx1"

rem Check if the file exists
if not exist "!input_file_path!" (
    echo File "%~nx1" not found.
    pause >nul
    exit /b 1
)

rem Calculate hashes and show them
echo. && echo Hashes for file: "%~dpnx1"
set "count=0"
for %%A in (MD5 SHA1 SHA256 SHA384 SHA512) do (
    set /a "count+=1"
    for /f %%B in ('powershell -Command "(Get-FileHash -Path '!input_file_path!' -Algorithm %%A).Hash"') do set "hash_%%A=%%B"
    echo   !count!. %%A: !hash_%%A!
)

rem Pause the script to show the hashes and wait for the user to press any key to close the window
pause >nul 2>&1 && goto endapp

:endapp
endlocal
exit /b %errorlevel%
