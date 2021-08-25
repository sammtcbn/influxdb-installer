@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

call influxdb-download-windows_amd64.bat
call nssm-download.bat
call sed-for-windows-download.bat

mkdir C:\influxdb

copy /Y "%currdir%\windows_service_create.bat" C:\influxdb
copy /Y "%currdir%\windows_service_delete.bat" C:\influxdb
copy /Y "%currdir%\windows_uninstall.bat" C:\influxdb
copy /Y "%currdir%\nssm.exe" C:\influxdb

sed -i "s|/var/lib/influxdb/||g" influxdb\influxdb.conf

xcopy /Y "%currdir%\influxdb\*.*" C:\influxdb
if %errorlevel% neq 0 (
    echo Fail to install influxdb
    pause
    goto End
)

call windows_service_create.bat

:END
echo bye
timeout /t 5