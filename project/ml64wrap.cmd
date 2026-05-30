@echo off
setlocal enabledelayedexpansion
set "fo="
set "rest="
set "file="

:parse
if "%~1"=="" goto run
set "a=%~1"
set "matched="
if /i "!a:~0,3!"=="/Fo" set "matched=1"&set "fo=!a!"
if /i "!a:~0,3!"=="-Fo" set "matched=1"&set "fo=!a!"
if not defined matched (
    set "rest=!rest! !a!"
    if /i "!a:~-4!"==".asm" set "file=!a!"
)
shift
goto parse

:run
set "asm=ml64.exe"
if not "!file!"=="" (
    echo !file! | findstr /i "armasm\|arm64" >nul
    if not errorlevel 1 set "asm=armasm64.exe"
    echo !file! | findstr /i "win32" >nul
    if not errorlevel 1 set "asm=ml.exe"
)

rem Default by system arch if no file detected
if "!file!"=="" (
    if /i "%PROCESSOR_ARCHITECTURE%"=="x86" if not defined PROCESSOR_ARCHITEW6432 set "asm=ml.exe"
    if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "asm=ml64.exe"
    if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "asm=armasm64.exe"
)

set "cmd="
if /i "!asm!"=="armasm64.exe" (
    if not "!fo!"=="" set "cmd=-nologo -o !fo:~3! !rest!"
) else (
    set "cmd=/c /nologo"
    if not "!fo!"=="" set "cmd=/c /nologo !fo! !rest!"
)
if "!cmd!"=="" set "cmd=!rest!"

%asm% !cmd!
