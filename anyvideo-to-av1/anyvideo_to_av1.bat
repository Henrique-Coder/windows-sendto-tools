@echo off
chcp 65001 >nul 2>&1
setlocal EnableDelayedExpansion

rem Set terminal title
title Any video to AV1 - Developed at gh@Henrique-Coder/windows-sendto-tools

rem Set input file path from the first argument and the default output file name prefix
set "input_file_path=%~1"
set "default_output_filename_prefix=-libsvtav1"

rem Checks if the input file exists
if not exist "%input_file_path%" (
    echo. && echo [error] Input file does not exist. Try again with a valid file. && goto endapp
)

rem Checks if "ffmpeg.exe" and "nircmd.exe" exist in the PATH or in the current directory
where /q "ffmpeg.exe"
if errorlevel 1 (
    echo. && echo [error] "ffmpeg.exe" does not exist in PATH or current directory (download it from https://ffmpeg.org/download.html) && goto endapp
)
where /q "nircmd.exe"
if errorlevel 1 (
    echo. && echo [error] "nircmd.exe" does not exist in PATH or current directory (download it from https://www.nirsoft.net/utils/nircmd.html) && goto endapp
)

rem Set video codec, audio codec and audio bitrate
set "video_codec=libsvtav1"
set "audio_codec=libopus"
set "audio_bitrate=128"

rem Set output file name prefix
:output_filename_prefix_choice
echo. && set /p "output_filename_prefix=Output filename prefix (default: "%default_output_filename_prefix%") [allowed: alphanumeric, underline, hyphen and dot]: "
if "%output_filename_prefix%"=="" (
    set "output_filename_prefix=%default_output_filename_prefix%" && goto extension_choice
)

rem Set output file extension
:extension_choice
cls && echo. && echo Output filename prefix (default: "%default_output_filename_prefix%") [allowed: alphanumeric, underline, hyphen and dot]: %output_filename_prefix%
set /p "output_extension=Output file extension (default: "mp4") [allowed: "mp4", "mkv", "webm"]: "
if "%output_extension%"=="" (
    set "output_extension=mp4" && goto start_transcoding_task
)
if not "%output_extension%"=="mp4" if not "%output_extension%"=="mkv" if not "%output_extension%"=="webm" (
    goto extension_choice
)

:start_transcoding_task
rem Clear screen and set output file path
cls && set "output_filepath=%~dp1%~n1%output_filename_prefix%.%output_extension%"

rem Show transcoding information
echo. && echo [info] Starting file transcoding... && echo.
echo [info] Input file: "%input_file_path%"
echo [info] Output file: "%output_filepath%" && echo.
echo [info] File extension: "%output_extension%"
echo [info] Video codec: "libsvtav1"
echo [info] Video bitrate: (same as input)
echo [info] Audio codec: "%audio_codec%"
echo [info] Audio bitrate: "%audio_bitrate%kbps"
echo.

rem Runs transcoding using the "libsvtav1" codec for video and the determined settings for audio
"ffmpeg.exe" -i "%input_file_path%" -c:v %video_codec% -c:a %audio_codec% -b:a %audio_bitrate%k -y "%output_filepath%" -hide_banner -stats -loglevel warning
if errorlevel 0 (
    echo. && echo [success] File transcoding completed: "%output_filepath%" && "nircmd.exe" moverecyclebin "%input_file_path%" && goto endapp
) else (
    echo. && echo [error] File transcoding failed. && goto endapp
)

:endapp
endlocal
timeout /t 5 >nul 2>&1
exit /b %errorlevel%
