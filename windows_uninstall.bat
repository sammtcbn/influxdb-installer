@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

call windows_service_delete.bat

cd C:\

rmdir /s /q C:\influxdb
if %errorlevel% neq 0 (
    echo Fail to uninstall influxdb
    pause
    goto End
)

:END
echo bye
timeout /t 5