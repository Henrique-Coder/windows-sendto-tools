@echo off
setlocal EnableDelayedExpansion


:: Set terminal title
title Fileditch Sender - Developed at gh@Henrique-Coder/windows-sendto-tools

:: Ensure that 'curl' is installed and available in the PATH
where curl >nul 2>&1
if errorlevel 1 (
    echo Error: 'curl' command not found. Please install 'curl' and make sure it's in the PATH.
    pause
    goto endapp
)

:: Clearing the screen and showing program information
cls
echo.
echo + -- - Developer: https://github.com/Henrique-Coder - -- +
echo.
echo -- --- - Uploading status - --- --
echo.

:: Set the initial value for the filename
set "filename=%temp%\temp_fileditch_response.json"

:: Remove the temporary file, if it exists
del /f /q "%filename%" >nul 2>&1

:: Uploading the file, getting the direct link, and copying it to the clipboard
curl -i -F "files[]=@%~1" https://up1.fileditch.com/upload.php | findstr "\"url\"" > "%filename%"
if errorlevel 1 (
    echo Error: Failed to upload the file. Please check your internet connection and try again later.
    pause
    goto endapp
)

:: Extracting the direct link from the response
set /p output_url=< "%filename%"
set output_url=%output_url:"url":=%
set output_url=%output_url:"=%
set output_url=%output_url:,=%
set output_url=%output_url: =%
set output_url=%output_url:\/=/%

:: Copying the direct link to the clipboard and removing the temporary file
echo !output_url! | clip >nul 2>&1
del /f /q "%filename%"

echo.
echo -- --- - The direct url was copied to the clipboard - --- --
echo.
echo + Pathfile: "%~1"
echo + URL: !output_url!
echo.

:: Creating and updating the fileditch_urls.txt file with the log information
set "log_file=fileditch_urls.txt"
if not exist "%log_file%" (
    echo Logs from https://github.com/Henrique-Coder/fileditch-file-sender > "%log_file%"
)

:: Creating a temporary file to hold the new log
set "temp_log_file=%temp%\.temp_fileditch_urls.txt"
echo Fileditch upload log from %date:/=-% at %time:~0,8% >> "%temp_log_file%"
echo    Filepath: "%~1" >> "%temp_log_file%"
echo    URL: !output_url! >> "%temp_log_file%"
echo. >> "%temp_log_file%"

:: Appending the previous logs to the temporary file, if it exists
if exist "%log_file%" (
    type "%log_file%" >> "%temp_log_file%"
)

:: Replacing the original file with the temporary file
move /Y "%temp_log_file%" "%log_file%" >nul

pause
goto endapp

:endapp
endlocal
timeout /t 5 >nul 2>&1
exit /b %errorlevel%
