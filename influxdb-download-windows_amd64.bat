@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

set INFLUXDB_VER=1.8.10
set zipfile=influxdb-%INFLUXDB_VER%_windows_amd64.zip
set INFLUXDB_FOLDER_NAME=influxdb-%INFLUXDB_VER%-1

curl --fail --output %zipfile% https://dl.influxdata.com/influxdb/releases/%zipfile%
if %errorlevel% neq 0 (
    echo Fail to download %zipfile%
    pause
    goto End
)

if not exist %zipfile% (
    echo %zipfile% not found
    pause
    goto End
)

powershell -command "Expand-Archive -Force %zipfile% ."

if not exist %INFLUXDB_FOLDER_NAME%\influxd.exe (
    echo Fail to extract %zipfile%
    pause
    goto End
)

rename %INFLUXDB_FOLDER_NAME% influxdb

:END
echo bye
timeout /t 5
