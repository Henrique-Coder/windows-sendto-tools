@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION


:: Fileditch Sender - Developed by https://github.com/Henrique-Coder
TITLE Fileditch Sender - Developed by @Henrique-Coder

:: Ensure that 'curl' is installed and available in the PATH
WHERE curl >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO Error: 'curl' command not found. Please install 'curl' and make sure it's in the PATH.
    PAUSE
    EXIT /B 1
)

:: Clearing the screen and showing program information
CLS
ECHO.
ECHO + -- - Developer: https://github.com/Henrique-Coder - -- +
ECHO.
ECHO -- --- - Uploading status - --- --
ECHO.

:: Set the initial value for the filename
SET "filename=%temp%\temp_fileditch_response.json"

:: Remove the temporary file, if it exists
DEL /F /Q "%filename%" >nul 2>&1

:: Uploading the file, getting the direct link, and copying it to the clipboard
curl -i -F "files[]=@%~1" https://up1.fileditch.com/upload.php | findstr "\"url\"" > "%filename%"
IF ERRORLEVEL 1 (
    ECHO Error: Failed to upload the file. Please check your internet connection and try again later.
    PAUSE
    EXIT /B 1
)

:: Extracting the direct link from the response
set /p output_url=< "%filename%"
set output_url=%output_url:"url":=%
set output_url=%output_url:"=%
set output_url=%output_url:,=%
set output_url=%output_url: =%
set output_url=%output_url:\/=/%

:: Copying the direct link to the clipboard and removing the temporary file
ECHO !output_url! | clip >nul 2>&1
DEL /F /Q "%filename%"

ECHO.
ECHO -- --- - The direct url was copied to the clipboard - --- --
ECHO.
ECHO + Pathfile: "%~1"
ECHO + URL: !output_url!
ECHO.

:: Creating and updating the fileditch_urls.txt file with the log information
SET "log_file=fileditch_urls.txt"
IF NOT EXIST "%log_file%" (
    ECHO Logs from https://github.com/Henrique-Coder/fileditch-file-sender > "%log_file%"
)

:: Creating a temporary file to hold the new log
SET "temp_log_file=%temp%\.temp_fileditch_urls.txt"
ECHO Fileditch upload log from %date:/=-% at %time:~0,8% >> "%temp_log_file%"
ECHO    Filepath: "%~1" >> "%temp_log_file%"
ECHO    URL: !output_url! >> "%temp_log_file%"
ECHO. >> "%temp_log_file%"

:: Appending the previous logs to the temporary file, if it exists
IF EXIST "%log_file%" (
    TYPE "%log_file%" >> "%temp_log_file%"
)

:: Replacing the original file with the temporary file
MOVE /Y "%temp_log_file%" "%log_file%" >nul

PAUSE
EXIT /B 0
