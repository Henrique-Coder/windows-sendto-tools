@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion


REM Creates the input and output path variables of the video file
set "input_file_path=%~1"
set "output_filepath=%~dp1%~n1-libsvtav1.mp4"

REM Checks if the input file exists
if not exist "%input_file_path%" (
    echo. && echo [error] Input file does not exist: "%input_file_path%"
    goto endapp
)

REM Checks if "ffmpeg.exe" and "nircmd.exe" exist in the PATH or in the current directory
where /q ffmpeg.exe
if errorlevel 1 (
    echo. && echo [error] "ffmpeg.exe" does not exist in PATH or current directory
    goto endapp
)
where /q nircmd.exe
if errorlevel 1 (
    echo. && echo [error] "nircmd.exe" does not exist in PATH or current directory
    goto endapp
)

REM Runs transcoding using the "libsvtav1" codec for video and "libopus" for audio
echo. && echo [running] Starting file transcoding. && echo.
"ffmpeg.exe" -i "%input_file_path%" -c:v libsvtav1 -c:a libopus -b:a 128k -y "%output_filepath%" -hide_banner -stats -loglevel warning
if errorlevel 0 (
    echo. && echo [success] File transcoding completed: "%output_filepath%"
    "nircmd.exe" moverecyclebin "%input_file_path%"
    goto endapp
) else (
    echo. && echo [error] File transcoding failed.
    goto endapp
)

:endapp
endlocal
timeout /t 5 >nul 2>&1
exit /b %errorlevel%
